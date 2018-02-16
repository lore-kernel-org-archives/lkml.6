Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeBPEE3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 23:04:29 -0500
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:34940
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751342AbeBPEE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 23:04:27 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Linu.Cherian@cavium.com;
Date: Fri, 16 Feb 2018 09:34:04 +0530
From: Linu Cherian <linu.cherian@cavium.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Linu Cherian <linuc.decode@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sunil.Goutham@cavium.com
Subject: Re: Handling active DMA during a VFIO application crash
Message-ID: <20180216040404.GA12253@virtx40>
References: <20180215110406.GA15219@virtx40>
 <20180215092109.51dc7a1a@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215092109.51dc7a1a@w520.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0083.INDPRD01.PROD.OUTLOOK.COM (10.174.208.151) To
 DM5PR07MB3435.namprd07.prod.outlook.com (10.164.153.14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb05fded-7bb3-492a-4230-08d574f25d78
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3435;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3435;3:U9cefFhZsRUUkmNbF8tbisDJYf5K+z81vnHmIlpbcya3f3G1yJ0WGFHGgQLfbYto5GQaDSLS99LRvoXLUJ7bQsVBY52vUzLR2BuXjGwIPHlc9bnT3qB06nBa15whMj1HLMu7Egg00tzk5qr1OdlTLK5sg7nd7ZIy99DUzl5yoQ/0iD2JA7vTYS7qrdTEQnq3f0JwuW/U3BuLQPMebOhHujJHlBakXjIiS1/1tqTcB69T4gWYSjcZTqoWfxEXYqdy;25:OgIb5quI5TZBYSCfWatK6TOyLx3doHBOiV1nXsltHLhSMj+cltuj7+mVkRfZIkn2IVn9LUqoTGEpUMrWy7Bme/gD20A4ERDU+GX6OrzOmEBBl0rscePX7HEshicUtlpseOwN2LnhnBv4uhezU/U53I0jVb5/O0/dFD6mwgA6cW8p2lBisU/adI5d3y8hcEvGCXFktebiv0n2sL2yZJ8sDW6YnTp2G+33ZVcgt5oN+7HtgwPMMFUTNxVoFr13QjapBFdoRdp9zrXMTIFwVIcHZzgGVLWjghIayH/oEVeSAplgG3FHwjpZd+GVrnxJWqj6eQ3MR2QBw4M//dO1wVxVvQ==;31:DURhf7nYikS3USp0UtWZ3MnDdOGTaf+8t4cWpp3bLax9DaYZtNRW1O2EmnsU7+4Pab99vU54YkiRF25z9LOZTCHcMPF0G3kqS1brAeyJf43xQR89uOXYwthXpXBfSVStUnIFzCxzgC2rA/7CRfLL2lCMYTzs47LjhSH5avQWICrCNbfWbT/5tOY9W878bjt7EdlRqTzUQVuyVoSExbvdUCmiQWuTncI1K0wq7DjU64o=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3435:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3435;20:dGm5R+zkVr7IBxfEfANXA7F3f/wAueDImFP8JFnyGkCilmaAQLxfxw0I0LIBSvynPjn2e9hgHl6YUlKi0TCPAM4HZX/9wFD74bv/e5rKLHLrBXX5WB98RqQRba/7xGhPcsjnrGcACyCZsww6UJVTjy+RfGQKMEOKBxotgorW/TYPEezwQplvVZ45vLs6tb2Ul1cqEK7ZJDMwD38Eyy77AJtxNypHx0EwsnIX3RAON2FtgWm2CtP25gWcQVktSSRIEErZ6zeX4ZB1IATMVnzdDZJjw1UZPCjEH9X0eE56d4f2FioqTMqhl5W5uMNt1V+gasDwxrlOQCBcqYYK2wuB7Fcyg3pyFn9Og3HSA1M2crI+qDa2Edq5h1I3IXqT++RUz4ysc4cxz8VRyiZBPTw6JkmHPwxnrm5rLfILQXlM6ueFAcnXRiwYm+Xd0Y740kLqYFNUDY1aDMNWEGwlLlpBIIX79jBHslTK8bSuCB3SmqL3m3hpAPi/yOWZEFsqdu+n;4:nOkH3AGMhMoVkCo6D0TtLbuNvrOjnfuML6mL4x7couEEdhrzT6bmQfLbc4mlE5xwIhhCvA4/5HWs4+H7Ng7lXujaZAkgDcs+796Mo5U0e084RYFMi76ZoW1P5w9NemGwHFPzV5QVLg6hhq9ctGfOR/EBvpKw3Ckg/9pY+93YP/9qeVdAquQPVghUBxVetgPHS4dV2shYBvpqoGxQUAJYxDdCV3S9bE1n5lUWm/uR4mQBUiUmzBuTkyeJpHJJIh0RuYLQJ79SY5mOqfR53VheeBF5lcvfOiyuRmNsJPeL3jPWocJO41VUM+46VVDlqLFu
X-Microsoft-Antispam-PRVS: <DM5PR07MB34358C0085BA04C9D8DCC606FACB0@DM5PR07MB3435.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6041288)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3435;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3435;
X-Forefront-PRVS: 0585417D7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(51914003)(2906002)(107886003)(4326008)(39060400002)(33656002)(81166006)(81156014)(8936002)(106356001)(105586002)(50466002)(68736007)(6916009)(33716001)(47776003)(83506002)(5660300001)(8676002)(52116002)(66066001)(2950100002)(6246003)(16586007)(316002)(42186006)(58126008)(186003)(23726003)(72206003)(478600001)(229853002)(86362001)(575784001)(26005)(305945005)(7736002)(76176011)(33896004)(386003)(1076002)(9686003)(97736004)(59450400001)(53936002)(3846002)(6116002)(122856001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3435;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3435;23:JgdJCjpYBlLBSVGfjNamdK9q7aKrv+udptZuYrADB?=
 =?us-ascii?Q?m0IZ4n32ayFo060MGZ9i9V896esexVYSajjxk8amFvGnUM3U9VzB4PnzCMz1?=
 =?us-ascii?Q?m+SpXU9nHl6PAOtG4zMZw7wkga/ashJrb++BbBeEnH4p0R5g3oV9gVVpT+6/?=
 =?us-ascii?Q?yGwBoFa1uw21c81JkZ8+eSNP0Uqm3T0GKl7LCKzMwpVqt5/MPum0x/92C5RY?=
 =?us-ascii?Q?q076wHSeljJF9e0xuAcgI/bgranAwA3aig/mw7JcQiiMjy6YBRWbBPWNezBD?=
 =?us-ascii?Q?ccxZu01yBr/k7n6b9YLDYKWXS25sxfE5RIwL+EOm1+W4p3qX4lL9ugc4L/cF?=
 =?us-ascii?Q?u7AKuRm6RpFKf9yCEunPHYRBptXuwxZn4Q4tTZm20C8ceGOuYfFwO3KDOvym?=
 =?us-ascii?Q?xVcuX3h1kIgZslFMjGXor2OnaPTkl26awWjbL490yiFIHnDFzhc6spSqnIvd?=
 =?us-ascii?Q?K0se6wAdNHlgYNI8hbySypCLxFwKf3jx8S6w6KXvRjbAb5VCozPf+6wgHLY8?=
 =?us-ascii?Q?rc4zDjwUX/kI48mAlTkZK3uAFAZW5y4ekUDJiuZjBAtE2Xhr26WY/+2ksMzg?=
 =?us-ascii?Q?H6+tWBBaxP+qBAgE/H3YHj5Fjm0NOhKNkkpFm/Zb6lBvfOxrk8udYm3BdI+v?=
 =?us-ascii?Q?mKo64bTZPqsnJMV9aLhmF1nwlvLccanrrqt0hiYwgCOFOL0/j88Q5nwsDZMi?=
 =?us-ascii?Q?81OFpf41h2iiaA+At5UFWeYe4eWFjX4kEKin0ggSxipIuFbKAo+6oHYJqkld?=
 =?us-ascii?Q?TNuv3SopMSliRLBjGCMfzHuaj/QolgVep4bdKG9IaaoxsGid7madMju5vC2b?=
 =?us-ascii?Q?MpHvYm+6gTN0HsrE2FiP/97CP9zXcDJ5EykKPWI2Mu4s14Vs6wkPolmvoX/f?=
 =?us-ascii?Q?RGbFxsP3gjnVve68s0uVDoFOHDsPFVWgJeCg6kq3ST7md+4VyNSd4masnX89?=
 =?us-ascii?Q?N706RO8utyBzrkYGCNxHe5EnZDXTQSHZ2K3Kl7F7cJxfxgpzn+4U8dO6uwIh?=
 =?us-ascii?Q?2mDYEDJBVDAFD3pR3oyag5Tr+GdnCw8nFHjp9gNg0qJ/h4zrmOej7xPxUa1N?=
 =?us-ascii?Q?1FQWSvgIsGdLq0fGOBubhVQSaXw2GsWVr7mdr/sZ9VyFpZhe3GQXRG6wJnEI?=
 =?us-ascii?Q?CYHRYyJUUzb3U2F2HPkJTSeBLO/kqV3sA9KLtbrfv1DCnHJNmMZUqu+AYff1?=
 =?us-ascii?Q?6mBmQCvGn69AguhS2SjywjKt3CbFitDzqQpz8J9DN2PhfZU5MrTu0EFCv95n?=
 =?us-ascii?Q?/5si/X/6ffo20a+0Zh/Pmaf3W9NFyX4Nvs5XnMBpxugwPqBQ4iJ9XSufSt2o?=
 =?us-ascii?Q?D937A2TQ4eVChv+ABJAn8huxRtd8dg6iApbf09fMlD+?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3435;6:sjJWc3juhDj663VVDsONjWtLYGO5zzBa3XKq7xO91e8CZT9oz35IJBfQYQPdwLS+/jKR1QqtkfwSKoYQMlqgOJJAuf6UuLBn2Y+unoYDNtRT3SowjK0KXtt3IhVL/yYiT1oqZZ5K/F9ArH7FAW4B4kJpBv1qwcrzRdmaHUmpc0V5Sr7CS60dAJ9xdoAQhPdYsgVwiAhpuPS67xdpvMXOTSMTAgqbNnNNGVsgTL8b36cLbeBhY8yurvMIQ303r/lVRqeD3neOpxpr8RUgEATj3DEePmF4sNGwqyT7iLZAQPj6Hc6KLIr+AD+dqU07cBjOnNFGh+gDJ8zsJ3IjxtjZcMlndjgWqRYG/x6qQiE6adk=;5:ZYBoIknpoCc6b922Qn0wrRz+juUG9zebxbjoArQzqMO2Q+HZxv1RdnpuewiGENy/NrDpydm/gUdVTEMq6YcvA3xWCs2jGdVyxV0/i7Herqwlv5+F1QLcrSWVHRbZcXb6QMRSYDjfcPg3co3Ufxd8PdbDU8qWt14ixFyu/6qn294=;24:0rCr5cioMSRrCnepV3xItwsvZid2xsLCrljcEzv7B9vsHoOeRkxYv9sgUHtGjSSuG4oVqYeuaebrs8YJeDzawO0Y/hTgTY+LSZzDEZOk9Hk=;7:wqhyKX3V+ixJBXY1GCUmCGpSO2VOL0CZLY4turSq7bRiqfQmhIDnjXvcZEoXjle+f+uka0VtayoiAwSZGSp0b7u6QUZgH4PDKaggnAzAbzxxti6RChGkzoCM91VW1wUj/0GG2rLoYG/ygf6Gd/lqE6hDYu35KdNshttBDR7ZKhqjSrISRNFqw47Bvwg7BHKPpllYhEDz+BA0t/U6aEMVeVntyJikD/s5l0238SdeeeJPptVrjui2UUJf8Ec37tvG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2018 04:04:22.4987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb05fded-7bb3-492a-4230-08d574f25d78
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3435
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu Feb 15, 2018 at 09:21:09AM -0700, Alex Williamson wrote:
> On Thu, 15 Feb 2018 16:34:06 +0530
> Linu Cherian <linuc.decode@gmail.com> wrote:
> 
> > Hi,
> > 
> > Was exploring the implications of an application crash while DMA 
> > is active from a vfio PCI device; the DMA being configured and 
> > started by the application using vfio APIs.               
> > 
> > The expectation is that, DMA is stopped/reset before we tear down the IOMMU mappings 
> > and finally free the mmapped pages(on which DMA is happening).                                            
> > 
> > From the below stack trace(with dump_stack in vfio_pci_release),             
> > [  201.564273] [<ffffff8008798b50>] vfio_pci_release+0x80/0x458
> > [  201.564276] [<ffffff8008792b74>] vfio_device_fops_release+0x2c/0x50
> > [  201.564279] [<ffffff8008269ef4>] __fput+0x9c/0x218
> > [  201.564283] [<ffffff800826a0e8>] ____fput+0x20/0x30
> > [  201.564286] [<ffffff80080e7fe0>] task_work_run+0xa0/0xc8
> > [  201.564289] [<ffffff80080cbc7c>] do_exit+0x2bc/0x9c8
> > [  201.564293] [<ffffff80080cd0ec>] do_group_exit+0x3c/0xa8
> > [  201.564296] [<ffffff80080d94c4>] get_signal+0x3e4/0x538
> > [  201.564299] [<ffffff80080892f0>] do_signal+0x70/0x660
> > [  201.564302] [<ffffff8008089ce8>] do_notify_resume+0xe0/0x120
> >                                                                                                
> > 
> > PCI device is disabled/reset from vfio_pci_release invoked as part of 
> > device fd release. The fd releases are in turn invoked from exit_files
> > and exit_task_work.
> > 
> > But exit_mm, gets called before exit_files/exit_task_work in do_exit.
> >                                                                                                
> > Assuming all pages allocated/mmaped to a process gets freed in exit_mm,                                                                                               
> > is there is a possibility that user pages configured for DMA can get freed 
> > to kernel before the vfio device is stopped/reset ? 
> 
> Pages mapped through the IOMMU are still pinned, so they have an
> elevated reference count and I believe therefore cannot "get freed to
> kernel".  Nothing should therefore be able to allocate those pages
> until the container is released, which happens even after the device is
> released.  Thanks,
> 
> Alex


Thanks for the clarification. I will dig through the code on this.

-- 
Linu cherian

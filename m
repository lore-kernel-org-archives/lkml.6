Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933429AbeBMGXb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 01:23:31 -0500
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:26205
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751682AbeBMGXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 01:23:24 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jayachandran.Nair@cavium.com;
Date: Mon, 12 Feb 2018 22:23:10 -0800
From: Jayachandran C <jnair@caviumnetworks.com>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Message-ID: <20180213062244.GA4198@jc-sabre>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (52.132.42.17) To
 BY2PR07MB663.namprd07.prod.outlook.com (10.141.224.21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f74e87d9-9abf-4238-6e20-08d572aa4875
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BY2PR07MB663;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB663;3:jM+xOkiw8RtqTT8bLKxB9j4tUtkudVpvJpoBruiMAJTnEVCmtZnm7o3X1DxCPRO7luT1WEXyZ1jSo/RFixuJPrx386tRCeDRoXI0DImDir4z2FHQWn/V1X/luSMqWUDid+sv8hD3vt8D8Uv+eTxFjX8pXPQNPqEj5H7EHxKXaWR6idsn4qXm5kj1PecJZpUXTf+vldhfr+jAWjIkhJT+EyqBhjLCwbCikyDBtpV8+2eqyQwuAti+rK8zx6zMfDA1;25:yjZ43tIrWurlrocwIngyip8o9VFIlgyNzCuigpFDKbyNB/EIoN+PrU36y3z4sqVVWjCy09NQ8cJXrvsq1aGbsg4r4U0IajvKmJiH2tY1qFIVCufs73tEg12ZVQtJ2dlIBSNCSGPG5C2Z+qP3ib9wcl8SKUy6wG3A3kiL+E2Bp2mrk0A/kir0jkFlaFdu5dTUMTrDObgxEiKlNimeuFJtljbFc55P5xa1SQng+xBr3J9PHAcgaymK79ihRfumzTk3FvkjAWlSQDEvlwaOjNdYF6cdnmyAyWsTFWVeauRbSZSJqpWHpyOi7fWLRp5OcqK0iene7Um8PVPjYwWhWxVPyQ==;31:VYv9CbPoKLfvNZTdvvfxwKccFfZ1AsTb3cugoAauMiZld7Oc4VBfLM4J6W6mTvTOdkspPXC9gBYxSn6pGpiJ7otc+2c3aXN4DLLLaoVt//FVlVQM20T/c4SYwvWC57zfAqKaJEG0CAynNFkg5d/Su4NDHUtLZQGC5QICn9YEzzG9Zt3+UKzQ5kXiHv5WR4EPuOZghyDB1zYuNjZ2OMPIDKANl61ma7ozPvozyfwdXsg=
X-MS-TrafficTypeDiagnostic: BY2PR07MB663:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB663;20:Prr0SKtxyyAgsKG/RzATGtUc5FWgzKbMElmJnOtVPDdWv0CCohs3hFmVDVNz50jL4WvEaA6stu/90WxwDaAFvXsFQ15fto3v12boomErOZX2IHLIzHMTVqEL0XBY6obHi6rAnBvtkWfIxGAFC72jH33Q2ioUGDK5RkN2sRQMQarMOuBa/VrkRtHZIWvrGV4dbOmFD90EYXL8M6P8ZWL+ZaFRmHEPu0DzRdBDoO6cOERD5tuLivW23cPCNQFuDOg4/Wo8k3wWwORSo3WYNbsMkqlD2BOZ2BbygX9ESyNdqCxE/RPZkMbeyESLZMU2d22HRx84fDBNq0ejtAL6AspvgJ8VYPuqZhJ0Rv5cTEKFIpMId3mcvVtBqsi+E8GYN2hufuy8OCpPrke3VTSpc8K2Y/Zdtxn7ZO9sz8kAzgr7zXXGuDQ61MOg7QUyt3dBg+UQ4vLu8pcRBwwtgMFRSMfmkTo120HliVN47C8CucKUv9V5XmkC8MIEufb+zEJr8AVYodjQq/TVlXPnDTMpvuWYwdd1AQq9C4maREIrZhU8/yDg8T2DxlkoXPYqXuGzpjMyletehhPb7VYa9WzMAIDZCZPoWE5htBLUY/Bg7b3NgrU=;4:0ZVdO778+sV4pmahQWJBT87aKJPpuI1uhysJ3Ct3amNGk9KXmdcnSUCgf8/l4fJJp7n1C94tUoqT4EitvxZeGw9LwNTNy1sIDSxHjnAe5skbMfFpYZP4L/l62ooXvc45tIwoGkym4nXHUrBqyEpq4k2lxtqsqPufVYhu/9V7UyPxW0Fn7R3akBOj7K8qaDJwbnXG0HWEzDOS4XSuFe9DnG0B93GICIHOvkAe2+ghe7cNJV8fzdVzMZoLJ36LY2soWUY4VYpmMIcNqC6FijAA/g==
X-Microsoft-Antispam-PRVS: <BY2PR07MB6631A7ABE3D009EBCF28E8A84F60@BY2PR07MB663.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(944501161)(93006095)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR07MB663;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB663;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(305945005)(8936002)(33896004)(81166006)(1076002)(26005)(229853002)(2906002)(7736002)(66066001)(81156014)(83506002)(6666003)(316002)(76176011)(2950100002)(42882006)(478600001)(97736004)(59450400001)(106356001)(105586002)(58126008)(16586007)(47776003)(8676002)(386003)(50466002)(16526019)(3846002)(9686003)(4326008)(53936002)(45080400002)(25786009)(68736007)(5660300001)(72206003)(6862004)(33656002)(55016002)(107886003)(23726003)(52116002)(6496006)(6116002)(33716001)(6246003)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB663;H:jc-sabre;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB663;23:o2GV0W7s6gNiXjOS1godxjwDvSY5Tp0Po5J45J5Db/?=
 =?us-ascii?Q?YqOCeyEY9hVfW0n2ZfnJEEb+VIAhDZDKQH/qW2r7AvJHaMQMUecRUeBXc2wK?=
 =?us-ascii?Q?MtzHb0a61bVZz6WpDCy7KFtaGtWQ8qIcvd39DZYQaLjj8DcWt1S0YAM7/Q+e?=
 =?us-ascii?Q?pmx4ZaW3THTPEZWGPyFOIPZKFsIdOHBCw6P03WsTQPewCLAcGVibQiZMuu6J?=
 =?us-ascii?Q?ThJrqp1zLkeByc+0z5LHV6AxqAe3G2DnDsFaoixXBlIqsbTg7pqbIdlHiGiy?=
 =?us-ascii?Q?A3nMwCCuyuHRblYffdopXG8AVMfRJP12jYBy4vUWgfQn0CFIDihGqZCdHT8X?=
 =?us-ascii?Q?HLO9gzLLJMYcUFjLBHGHCtWGv0ZKw82t9B8tZ0eFC79ziWYJKnAUWbxjrQ/m?=
 =?us-ascii?Q?fUDEBafg0PbLPjVpzEzNfK3gQEIDC2lnnZQs2VgHDJEXDmM7bZ7Gy3KoO+6A?=
 =?us-ascii?Q?Otxz01DaSbU4FRGmI6vtCUdCMqvOdNGrWrA7tEEkkoOn4PU+mztis/B5znxb?=
 =?us-ascii?Q?gBZjJJBSnAwRp+/aMPa9zBVRtHWmfLxO3sB+ZVuY33764qdRdxpS9/9WRqSx?=
 =?us-ascii?Q?OcbD4tGZzkRAP2At1ifSp7ZTX32fuGUPUZmANiZQxmarCJZVmU1EhwtcD7Ez?=
 =?us-ascii?Q?+LouM/AtZZRqgjwjc+f7mra2TLgpUJUzMMemAcy5A10AJEb/XEfA5pG482cY?=
 =?us-ascii?Q?S/QsG9YTtnLCnRv4vKxZb1z7NnIM3/9HX1gTUULBmD5vJtOl4c9OeRZvCq78?=
 =?us-ascii?Q?4HeMme/MCdWIyT9/PeYeEQbhP9ClHk1gWh77vx5JX8ksggq0TFmRhQcjclW1?=
 =?us-ascii?Q?E7Q+BEZgSnKLsYsY3T68RU2JPw2F3UEvEHlePZRkZfqW2b1bjl/GEuU/k9s1?=
 =?us-ascii?Q?RaUOnEPGY7gfzSMtQIg9fvM9UBrMlRmv9CyIqF/kyLcIYqOLkfYTwvZIp+U4?=
 =?us-ascii?Q?pX+pfNtmEWd5QyDViTl+F8GrDhj5r1jEz1yG9njR+Nqg4j2TolSQOzvNpkhM?=
 =?us-ascii?Q?QGHtqBe41xcxCyN9PzbismoNbmdS3IntjZu7SWCbLBi+uiCXNPp9LlkgHIod?=
 =?us-ascii?Q?55qxS0EhV9cHL+4VBw0PxZkTCSyOy93VfH8He5yWHOoDIXijBdFh3c1VJSZq?=
 =?us-ascii?Q?ZQEodgugM/ES4cBCVKB9GIBQgT2oZX/OsZApcMB3mNIF3sq/0MJEI2tHsaU+?=
 =?us-ascii?Q?anxJIdgrLfj/xj+QCcIl5T97kx06+5t9EvEneeh1yr/dE0/2BlKw33qvitP0?=
 =?us-ascii?Q?VNykFXdtHRQXp973ATuzvKa0t4DqyRt33DVbDYlsWYq139KgRRqnN1xXLG9z?=
 =?us-ascii?Q?dHOhvZYdwHdYxRVXJImxgZzFbaN2re/DgLoelSnsUj?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB663;6:ZCI2uS9FZnDCA7dmsFHzcnDsOZgKQ1M7pFSu2Hj+0B2m0TsezhiW20YW+XkSG2n+KoN6VP2TRpFwr/A4TNuRy7x9TQCqhgEwt880JcxInQslqRxLxIKmRnHGoh6iCVMfEjHPScRc8E6G+zGgrYBqYAJ8P3kRuoacQkjBofa9mm8Lyb9aH5lK+O22xbZinFoqiyc4HLS4g+2XomyXP10tMOoQvVYUi02k22mpTcinymZonRAhNr5Yby11F9qQpLAMtny/+12mVGUmrR8EFte+4YL16L3L+eYPvIrV5NieYUMxXiOxISICU9FZWvNeybnN8CwUW7Mq00Qx45E7AQ5b3D+Z1BvJYhAKJ3aN8VqvKqY=;5:AB28L99rLtgep1U4nBuATpMCBu+n2Sv4fLnH3MTDGYhhLHXDiO4XTP7a2D9DUAQp8fnUH7jdqjVLvgznbXDiRu5UoNK94Vk9LnH3IBltaMpgQ4F+hSpbE/8b6F1Y8hRkm7ob58pbqt+sk1ujeLrHO/kGmTHiFik20UUax3tWljU=;24:FEtg95DZ9TvPG5atlKSqnHjPnORQfof9NzVHcKiAraAH7qccJ8ASxrubGtceuPqwsAazeymY8rumFs3hS1WIzjIVWw5cjgXeeLbAmSUsFvI=;7:ww2rCiGr33Thtm4zUKvFeyLTYKCkzZW6Cb8OEnilTAGeWPY5A1XsiOhnHon0TK4m1MU6w967QPmZKj6Cq6wKxCAmNXlVs+OZJAmfw1ZCGLpbjSVQhIe6OyZFEEpVjcMCxgOREuUuolTlIeqVa/8AkoQsTRsekWW9wvqWAT/r7Bcctejn+yj0m9lmbdl02SM7KMyTSp/mVimShOxX6VOXc2Ec304gkdClNdftX2PJ08WTawnC5DHpkpic/728cMLJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 06:23:20.8611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f74e87d9-9abf-4238-6e20-08d572aa4875
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB663
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 07:00:46AM +0000, George Cherian wrote:
> The PCIe Controller on Cavium ThunderX2 processors does not
> respond to downstream CFG/ECFG cycles when root port is
> in power management D3-hot state.
> 
> In our tests the above mentioned errata causes the following crash when
> the downstream endpoint config space is accessed, while root port is in
> D3 state.
> 
> [   12.775202] Unhandled fault: synchronous external abort (0x96000610) at 0x0000000000000000
> [   12.783453] Internal error: : 96000610 [#1] SMP
> [   12.787971] Modules linked in: aes_neon_blk ablk_helper cryptd
> [   12.793799] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-32-generic #34
> [   12.800659] Hardware name: Cavium Inc. Unknown/Unknown, BIOS 1.0 01/01/2018
> [   12.807607] task: ffff808f346b8d80 task.stack: ffff808f346b4000
> [   12.813518] PC is at pci_generic_config_read+0x5c/0xf0
> [   12.818643] LR is at pci_generic_config_read+0x48/0xf0
> [   12.823767] pc : [<ffff000008506f34>] lr : [<ffff000008506f20>] pstate: 204000c9
> [   12.831148] sp : ffff808f346b7bf0
> [   12.834449] x29: ffff808f346b7bf0 x28: ffff000008e2b848
> [   12.839750] x27: ffff000008dc3070 x26: ffff000008d516c0
> [   12.845050] x25: 0000000000000040 x24: ffff00000937a480
> [   12.850351] x23: 000000000000006c x22: 0000000000000000
> [   12.855651] x21: ffff808f346b7c84 x20: 0000000000000004
> [   12.860951] x19: ffff808f31076000 x18: 0000000000000000
> [   12.866251] x17: 000000001b3613e6 x16: 000000007f330457
> [   12.871551] x15: 0000000067268ad7 x14: 000000005c6254ac
> [   12.876851] x13: 00000000f1e100cb x12: 0000000000000030
> [   12.882151] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> [   12.887452] x9 : ff656d6e626d686f x8 : 7f7f7f7f7f7f7f7f
> [   12.892752] x7 : ffff808f310da108 x6 : 0000000000000000
> [   12.898052] x5 : 0000000000000003 x4 : ffff808f3107a800
> [   12.903352] x3 : 000000000030006c x2 : 0000000000000014
> [   12.908652] x1 : ffff000020000000 x0 : ffff00002030006c
> [   12.913952]
> [   12.915431] Process swapper/0 (pid: 1, stack limit = 0xffff808f346b4020)
> [   12.922118] Stack: (0xffff808f346b7bf0 to 0xffff808f346b8000)
> [   12.927850] 7be0:                                   ffff808f346b7c30 ffff000008506e2c
[...]
> [   13.269819] [<ffff000008506f34>] pci_generic_config_read+0x5c/0xf0
> [   13.275987] [<ffff000008506e2c>] pci_bus_read_config_dword+0xb4/0xd8
> [   13.282328] [<ffff0000085089f4>] pcie_capability_read_dword+0x64/0xb8
> [   13.288757] [<ffff000008513d28>] __pci_dev_reset+0x90/0x328
> [   13.294317] [<ffff0000085142d4>] pci_probe_reset_function+0x24/0x30
> [   13.300571] [<ffff000008518754>] pci_create_sysfs_dev_files+0x18c/0x2a0
> [   13.307173] [<ffff000008d9a974>] pci_sysfs_init+0x38/0x60
> [   13.312560] [<ffff000008083b4c>] do_one_initcall+0x5c/0x170
> [   13.318122] [<ffff000008d60dfc>] kernel_init_freeable+0x1c0/0x27c
> [   13.324205] [<ffff000008980d90>] kernel_init+0x18/0x110
> [   13.329416] [<ffff000008083690>] ret_from_fork+0x10/0x40
> [   13.334716] Code: 7100069f 540003c0 71000a9f 54000240 (b9400001)
> [   13.340805] ---[ end trace fc992038acd29ec3 ]---
> 
> Fix this by adding a quirk that prevents the root port from 
> entering D3 state. This is seen on both Ax/Bx variants of the processor.
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b1..2eb08a8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1154,6 +1154,18 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
>  
>  /*
> + * Cavium's Thunder-X2 Processors root port doesnot handle cfg/ecfg access to
> + * downstream properly if root port is put into D3
> + */

This comment can be fixed up a bit.

> +
> +static void quirk_no_rootport_d3(struct pci_dev *pdev)
> +{
> +	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM, 0x9084, quirk_no_rootport_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xaf84, quirk_no_rootport_d3);
> +
> +/*
>   * Some ATA devices break if put into D3
>   */

Bjorn, if you need an ack for ThunderX2:
Acked-by: Jayachandran C <jnair@caviumnetworks.com>

This fixes the crash seen on ThunderX2 with a few PCI cards. We had worked
around the crash earlier by passing "pcie_port_pm=off" on kernel command line.

JC.

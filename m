Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F98C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543E32083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Mfr9tv49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543E32083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbeGZInE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:43:04 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:18528
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbeGZInE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKCb45g229PsloXbGkjsAYk/4g4ymiF/rW6l9SpVJj4=;
 b=Mfr9tv49+/r4mcUBnMcAXnxWgvOMqsvdAK/gOVacNLokXHRyjBcvnqe5+fZuF5rZyWbb0wFqxlioeh0Awijd4wKAFubTcVE2fMAjJ4DN4+fqi8zUGrjSyOj63lt4bhc3HxIsfYOMiLSUTvRpwiR9BVQZeFV4EGZH8CmQQENBJCg=
Received: from HE1PR06CA0153.eurprd06.prod.outlook.com (2603:10a6:7:16::40) by
 AM3PR06MB1123.eurprd06.prod.outlook.com (2a01:111:e400:5873::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Thu, 26 Jul
 2018 07:27:12 +0000
Received: from AM5EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::201) by HE1PR06CA0153.outlook.office365.com
 (2603:10a6:7:16::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Thu, 26 Jul 2018 07:27:11 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 AM5EUR02FT040.mail.protection.outlook.com (10.152.9.8) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.995.12 via Frontend Transport; Thu, 26 Jul 2018 07:27:10 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 26 Jul
 2018 09:27:08 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Thu, 26 Jul 2018 09:27:08 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
CC:     <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fpga: fpga_mgr_free usage
Date:   Thu, 26 Jul 2018 09:27:07 +0200
Message-ID: <1774072.WaZ974bvVk@pcbe13614>
Organization: CERN
In-Reply-To: <CANk1AXRYAPMgvFo-oLEz0-WwUstTvKD5f0_5NkvKzEO3K1=f2Q@mail.gmail.com>
References: <5553262.evi6GU8epL@pcbe13614> <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com> <CANk1AXRYAPMgvFo-oLEz0-WwUstTvKD5f0_5NkvKzEO3K1=f2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(438002)(199004)(189003)(52314003)(446003)(45080400002)(33716001)(9576002)(76176011)(426003)(106466001)(4326008)(336012)(230700001)(8676002)(26005)(97756001)(6246003)(53546011)(8936002)(74482002)(11346002)(33896004)(186003)(50466002)(16526019)(486006)(305945005)(9686003)(14444005)(6916009)(575784001)(229853002)(36916002)(6116002)(86362001)(7736002)(316002)(47776003)(7636002)(478600001)(356003)(246002)(106002)(23726003)(2906002)(966005)(54906003)(476003)(5660300001)(6306002)(46406003)(44832011)(126002)(786003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR06MB1123;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5341311-cd8c-43f6-fe76-08d5f2c933c5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR06MB1123;
X-MS-TrafficTypeDiagnostic: AM3PR06MB1123:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB1123;20:/ys7CcAWR2HkZAM5kVkC8xi9a8pVjiQ+DykdhoxoHtXEgU3f8BDlWu4ed700QYVFbzvDvmBMMu0UkqNAS7fEHxtmP+xiT2F6rof9Xavg5L0BhWQ/2VvcjwxaB+U7E+g7Feho3Ok+ct/3hBoFulRzbCskLfMBwoZ765TMQaxKZPGejsqQaKDWSZscjfPsMv4TUG4kpV0WJRFFkVJ6Wwn1cHhmXUbb8WyyZIGwsFmjZITztlMIkMSUFY0YQvavwMJVlx+7/w9/ZR9tZ1OHmOgBtIvMNk+o1gZopjwlnCqanqpeGRf9y4lIZ6DXOPZEq6eyqyH/W5FCQnTlHt041OmxceZxdJx0+qKDsFYebxcZjve9EDmbzBH4X5czEvGd9ZLHrembLiXCDQkWNzubQfKXy+rOybFMeIr+7Fpu5hYGWWQ12bmvoMGwT2xB9/WtfLA15HR9+Ka4mRGbVVAG5CNO4GjYE2IqtFEn+P81Y7Xt3U5esXLKqyu2Tnr8EBfRsffx;4:XkjEzRCFChEORXQ1H8Wdxe3runXzdfmPHi23kQa48uwyHufGGGVYyf7vaFwOgfOHt2tG5pVISKkh6R7hxmpPyrmCbDlps1pqgf/ssE6z6T+t1KNHJ5QlgIbdaGK8o47LjgMY5Eq3M66aM/o3U6f8QE4vG872vu+1D89zxjc3L7oPbfNvbqHSbBhdJAwYBM5QH6GaQiWUGWFH7T1R2e8RJeJfeVELktIYyTA5QnQy3at+mu5vnE8LNJZoVTC5naZW97dwDJwS9nZ9xPkWW6MZoQ==
X-Microsoft-Antispam-PRVS: <AM3PR06MB1123A9624555E3D0CB806E61EF2B0@AM3PR06MB1123.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR06MB1123;BCL:0;PCL:0;RULEID:;SRVR:AM3PR06MB1123;
X-Forefront-PRVS: 07459438AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR06MB1123;23:4YqcXzMJy3wH39rB7yc8QESXCyCxqWI5Or8KJHfJD?=
 =?us-ascii?Q?JfoQINMo8DiQJY6MW3EMwT1IEeTqq3ULvbZlmepUxwue/On4Wf9PrYuDbcXJ?=
 =?us-ascii?Q?93z3TBghhU04xjMmASsZhvl62083Z2hRPyVQ5EJhwiBmrM7j7QfVlnPESWbm?=
 =?us-ascii?Q?U1CUvh3zjpfHgssIbzoq0cuDIqaVPHON344PcA0r0PcoRFtQY/acceStQEx9?=
 =?us-ascii?Q?yzAPDorDQopcoS9Gakxn9Do6jhW6vrMxbZdZFIolMd6lT7mI0K1+Tv64EPRB?=
 =?us-ascii?Q?cJJRrJ9tJs7sOvQkng7bFRxuJxLFArrA4Afi6G4FTfqQxeJNTGACYdr+Brsi?=
 =?us-ascii?Q?9wFCsP4wpmISQLHZS/w6OFJBLdJwlWyH9SeuuzGC9dsfIeb918M8gl+3zya7?=
 =?us-ascii?Q?eA+b0hAYuyHOqOUQr0TvAnKJz0iNU4DPOBCRBbHtOJwAESKFLjuNn/wiLTYb?=
 =?us-ascii?Q?S6cQ9nrWMtcUqX1J5CQLwXMLE4yLfdsc5/yXpfuwIXoANKUWZf3YzeFP9ZTl?=
 =?us-ascii?Q?6Kh7tY419pXZZ+NKWNW2pgINjrFQXkeltA+vIAYKmvx6OY4CY7y0C0JpmUsC?=
 =?us-ascii?Q?NfrPd3wRO+lG1KMpQlm2Nu1Z+w6qjWzzHW7w2xdcbfo3n29JX5NZ//1m5bF6?=
 =?us-ascii?Q?pAqreGmo/q4NKTeZt1l10oP8+W6dOskbsJ6qrs85nPY2USMLkqx7Bd6ygFWg?=
 =?us-ascii?Q?voUvNDnWACS59SVr6teUI1quZf0za64AJc54qeduhKZbJdpGDuPjIoJ0qg6t?=
 =?us-ascii?Q?LXp32oXOe4eJAbkio0GMuzCYojkomz+mkB9WqSdRa3CGJdBFUHswne34Vg85?=
 =?us-ascii?Q?IcyeLiQm3khnSqEswOtz4ACIZpxc7fLbc0sLnYVvQVknC47yfIfirezybwIi?=
 =?us-ascii?Q?7vJCTsenHUkhwObbKqMELCm7gT9w8JEn6b2Sl/qgWJEnWS5IXDAdahZ6tZ2m?=
 =?us-ascii?Q?zzgcgbQWRbQEUFVadO6W8V0AJc20HJQaipqoDOjLjYEImvboF3tmiMK0YDPx?=
 =?us-ascii?Q?WHAQP4EctTQ/VGCIVHosjaaebY8YJH+doRrzT16b0TYIJEbScxFdn5DuM6xl?=
 =?us-ascii?Q?iUg1iuQk05Z/0Mfn+RSJS5LhdLrWJDNxt7mGnzGP6rslK7/HpeZwdv1lzaVI?=
 =?us-ascii?Q?d1BTpBlxwbTuoUxsci2VtzLzrR/7JWYtNJJaqRlfmhNBE1sV8Now4+fX2V+V?=
 =?us-ascii?Q?p7/5Jfz6XzX4upDuMdgwSkHaDicpMYsJ7qZUVvViR1pUUkKoTkuaHTreLhoQ?=
 =?us-ascii?Q?9I/sLRvWJommr5sRq7rUgxiak2O+Hzaliej0HP27tbAFcTrmwCOQBkCmnUJF?=
 =?us-ascii?Q?7kMb4SfQ6fh7RL2jzr/UeI=3D?=
X-Microsoft-Antispam-Message-Info: s+pYrCY7NlOFUh5b0UMtAbGgyylNONEhflsE9kW/Erw5x3Z9tcLck/8rABVTbm5jEyhlKYFxiYnfngJH4c2tqULS4lB5uAg27guG4fi6a6vk9p/qHdf5uX1m2cZS5eVHG7ztpYydkOgt/CwsvFZTeDbeuO4R8ovqms1Z2bc5cGWu76Tfp44vtMLoq1f+HQZJQETj2CX6fIkUkAqZs2QVEcEI8BOotHV3fkayuuv6NFs10OSdH9s9P4FF6ps+Txx3NVmSYb6I0HWFc1DkADc8whlUpdA2+d3fYWVIvOSdqwhI3GFaOkrKprYcTksZteq4t7Rp+wJPQVowIPGIJlPrSK0agB5thPpG1rr7biAbXts=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB1123;6:u2g3cOL19TN1yftnlNWenWY0+LOELvuLOzW+zReYKopSAYEZjxEAiO600SwtW6mcmoBpbFV3ZfEjz015+LGVrgOC9Z8uHqjlifpr9rsLnVg24TEBp1sRcE2kRaSWzCoPhAk36ocK06QvNaTTDrcYeE93hsk/NLmS0+RGmMeJXxvYJVSixygp/ZIs/ehCR6myLhn1Y591opitMoAwPZ4UhtiSTQdy2MjVEMdgoTFXl+56BDQSyBRO9ywP12Kmzr/bwy1HXv7YIz+MiuqFib2iwFrCRgQ4O4U4BKGdnLh6Ek8nyL7ydHnhzEGVKm2Iw6x2G7ZjFRNTVgUER7bdRNUFV3aVUVwpOPRpg8aVbZZgdxHQBIj7uoRRZAApabkbZJ6t5P8pMNjaad/jAKhtPV3hggFAd9DN26EvqsbgweFxbBCEWhDcknEACZw2itpm6t86PL5D0w332vuRF/YSugOkzw==;5:lzzzvHZgvjN4Tu6zjYcwMVHw87ic5kl7BBHmdb/XN4G6KBJB1fl2M3J/j+gbf/4iOAilLly4f2wuuHEfp/ZmWkhy7OQvpG/3a9CFJrcFrsgVT9PeS/TzWeLOzUtjJjWJ6iNSZWjLbAERqLjsFQb3Xy+ZY2daN+37D8qbRxIbnHE=;7:h9ddXde2/rJUSR36vAybG8rnOvOGm8Cbai5uK1UDxfHw2hpFFsXAJYkR3QYiXO5guNQF1CWMhPI3v5aSqfJArvRQQuv3OdHoaJsEWUdqCbatFmFYr9SAqYn8LlGeo/ByG1ZvrPxZAMMCk+c0ohpN8AClGIzHJ6ZF/dzQiDLu0goT6vne20uOiBYyvekC4XQztqQQH4985pDa6oPURv0C4wBA1g+BIvek9zs0pJ9xAB3hwVU+Ay8fDkVA+BcEQPuJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 07:27:10.2817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5341311-cd8c-43f6-fe76-08d5f2c933c5
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR06MB1123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 25, 2018 6:33:44 PM CEST Alan Tull wrote:
> On Wed, Jul 11, 2018 at 10:59 AM, Alan Tull <atull@kernel.org> wrote:
> > On Wed, Jul 11, 2018 at 7:38 AM, Federico Vaga <federico.vaga@cern.ch>
> > wrote:
> > 
> > Hi Federico,
> > 
> >> Hi Alan,
> >> 
> >> I have another point that I would like to discuss. It is about the
> >> usage of 'fpga_mgr_free()' which does not look like consistent.
> >> 
> >> This function, according to the current implementation, can be used by
> >> an FPGA manager user and it is used by the FPGA manager itself on
> >> device release. This means that the user can only use this function if
> >> fpga_mgr_register() fails (to clean up), otherwise the user must NOT
> >> use this function, otherwise we most likely get an oops (NULL or
> >> invalid pointer). The example here is correct, this is what we should
> >> do:
> >> 
> >> https://www.kernel.org/doc/html/latest/driver-api/fpga/fpga-mgr.html
> >> 
> >> But I suggest to document it better or prevent this type of mistakes
> >> from happening. Following a couple of proposals
> >> 
> >> ------
> >> 1.
> >> Document it better. This is easy, in the fpga_mgr_free() kernel-doc
> >> comment we explain that the use of this function must be limited to
> >> clean up the memory on a registration failure. If an FPGA manager has
> >> been successfully registered then it will be freed by the framework
> >> itself.
> 
> As I was researching this, I remembered why I implemented it this way.
>   See below for that explanation.
> 
> It looks like I'm going to switch to option 1 here and add more
> documentation for both fpga_mgr_free() and fpga_mgr_unregister().
> Note that fpga_mgr_unregister() already says that that it frees the
> manager, and the usage example already does the right thing, but I'll
> add more words to really beat the message in.
> 
> >> But still, this does not prevent an oops from happening.
> >> ------
> >> 2.
> >> Remove the fpga_mgr_free() from fpga_mgr_dev_release() and ask the
> >> user to free the manager when necessary.
> >> 
> >> This makes the usage consistent: the user creates and destroy its own
> >> objects. This is also consistent with our other discussion where we
> >> said, among the other things, that the module that uses the FPGA
> >> manager can the owner of the fpga_manager data structure.
> > 
> > You're not the first to complain about this.  I think I'll err on the
> > side of consistency and implement your option 2 here.
> > 
> > Alan
> 
> If you write a class or create a device, the kernel wants a release
> function and will give a warning if you leave it out.  The warning is
> "Device 'fpga0' does not have a release() function, it is broken and
> must be fixed." and comes from drivers/base/core.c.

True, but that function can be empty (in other words, it does nothing) and 
option 2 can be implemented as well without warnings. I do not think is that 
bad, for example if I allocate everything with devm_* probably I will not have 
much to do in my release() function.
Anyway, I do not have strong technical arguments in favor of option 1 or 2.

> I will add some more documentation to make it clear that once a a
> mgr/bridge/region has been registered, the cleanup will be handled
> automatically when the device goes away.  Until the
> fpga_(mgr|bridge|region)_register succeeds, the caller still needs to
> do cleanup.
> 
> I did find one bug while looking at this.  I'll post some patches.
> 
> Full message was:
> root@cyclone5:~# rmmod socfpga
> [   48.206235] fpga_manager fpga0: fpga_mgr_unregister Altera SOCFPGA
> FPGA Manager
> [   48.213677] ------------[ cut here ]------------
> [   48.218312] WARNING: CPU: 1 PID: 1369 at
> /home/atull/repos/linux-socfpga/drivers/base/core.c:895
> device_release+0x9c/0xa0
> [   48.229293] Device 'fpga0' does not have a release() function, it
> is broken and must be fixed.
> [   48.237904] Modules linked in: socfpga(-) altera_hps2fpga fpga_mgr
> fpga_bridge [last unloaded: fpga_region]
> [   48.247659] CPU: 1 PID: 1369 Comm: rmmod Not tainted
> 4.18.0-rc5-next-20180717-00012-ge5f548e-dirty #3
> [   48.256843] Hardware name: Altera SOCFPGA
> [   48.260858] [<c01137ac>] (unwind_backtrace) from [<c010dc04>]
> (show_stack+0x20/0x24)
> [   48.268582] [<c010dc04>] (show_stack) from [<c07d448c>]
> (dump_stack+0x8c/0xa0)
> [   48.275786] [<c07d448c>] (dump_stack) from [<c0123bc0>]
> (__warn+0x104/0x11c) [   48.282810] [<c0123bc0>] (__warn) from
> [<c0123c2c>]
> (warn_slowpath_fmt+0x54/0x70)
> [   48.290269] [<c0123c2c>] (warn_slowpath_fmt) from [<c052c9cc>]
> (device_release+0x9c/0xa0)
> [   48.298418] [<c052c9cc>] (device_release) from [<c07d904c>]
> (kobject_put+0xa8/0xe0)
> [   48.306047] [<c07d904c>] (kobject_put) from [<c052ec3c>]
> (device_unregister+0x2c/0x30)
> [   48.313939] [<c052ec3c>] (device_unregister) from [<bf01262c>]
> (fpga_mgr_unregister+0x58/0x74 [fpga_mgr])
> [   48.323475] [<bf01262c>] (fpga_mgr_unregister [fpga_mgr]) from
> [<bf02b01c>] (socfpga_fpga_remove+0x1c/0x24 [socfpga])
> [   48.334047] [<bf02b01c>] (socfpga_fpga_remove [socfpga]) from
> [<c0534be8>] (platform_drv_remove+0x34/0x4c)
> [   48.343664] [<c0534be8>] (platform_drv_remove) from [<c0532f64>]
> (device_release_driver_internal+0x180/0x230)
> [   48.353538] [<c0532f64>] (device_release_driver_internal) from
> [<c0533090>] (driver_detach+0x58/0xa0)
> [   48.362720] [<c0533090>] (driver_detach) from [<c0531bf8>]
> (bus_remove_driver+0x5c/0xb4)
> [   48.370781] [<c0531bf8>] (bus_remove_driver) from [<c0533a70>]
> (driver_unregister+0x38/0x58)
> [   48.379186] [<c0533a70>] (driver_unregister) from [<c0534cd0>]
> (platform_driver_unregister+0x1c/0x20)
> [   48.388370] [<c0534cd0>] (platform_driver_unregister) from
> [<bf02b688>] (socfpga_fpga_driver_exit+0x18/0x990 [socfpga])
> [   48.399113] [<bf02b688>] (socfpga_fpga_driver_exit [socfpga]) from
> [<c01ad948>] (sys_delete_module+0x1a0/0x1f0)
> [   48.409164] [<c01ad948>] (sys_delete_module) from [<c0101000>]
> (ret_fast_syscall+0x0/0x54)
> [   48.417391] Exception stack(0xee6dbfa8 to 0xee6dbff0)
> [   48.422424] bfa0:                   0001dce0 beba4be0 0001dd1c
> 00000800 0000000a 80080000
> [   48.430568] bfc0: 0001dce0 beba4be0 00000000 00000081 0001c22c
> 00000000 00000001 beba4dcc
> [   48.438708] bfe0: b6ecdd00 beba4b9c 00012b43 b6ecdd0c
> [   48.443773] ---[ end trace bcf003ed0f464330 ]---
> 
> Alan

Federico Vaga
[BE-CO-HT]



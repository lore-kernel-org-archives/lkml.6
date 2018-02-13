Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934754AbeBMQyC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:54:02 -0500
Received: from mail-ve1eur01on0136.outbound.protection.outlook.com ([104.47.1.136]:22311
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934279AbeBMQyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:54:00 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Tue, 13 Feb 2018 08:53:38 -0800
From: Andrei Vagin <avagin@virtuozzo.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: tip-bot for Jacob Shin <tipbot@zytor.com>,
        kirill.shutemov@linux.intel.com, linux-tip-commits@vger.kernel.org,
        tglx@linutronix.de, willy@infradead.org, gorcunov@openvz.org,
        bp@suse.de, peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@amacapital.net
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Handle 5-level paging
 boot if kernel is above 4G
Message-ID: <20180213165337.GA20735@outlook.office365.com>
References: <tip-b4b56015ed1c98cbc9469e35ebbc4373a2844030@git.kernel.org>
 <20180213065155.GA14087@outlook.office365.com>
 <20180213080816.vwh64jiz23frjiot@node.shutemov.name>
 <20180213084121.GA19906@outlook.office365.com>
 <20180213090249.vnjwitt657jabnlt@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180213090249.vnjwitt657jabnlt@node.shutemov.name>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:301:39::23) To HE1PR08MB0745.eurprd08.prod.outlook.com
 (2a01:111:e400:59b1::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ef4f39-04a7-493b-3c4e-08d573025ded
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB0745;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB0745;3:0gxksYzAmXDMjA1Mi092SJ9oAAczTJU4h9T1I90yYwjba0RZwbc6scF3jZfsfayl4ZngXtw+YJHkuj9yfJ/B5WIDjyYGrc4zSKYFrgG652tEGeysRQZ36tvQ2xvulqKSTvnhsx4klf0DK4ZgqtJUgp5tvPxAE5tW79NFuaR8IOWwO2/9+SL4OaW0ixufK1fB9wUb7woJCHgFSjDNDa+89sKCluP3CJ8TzbvYdvc4a5DsWhfWYzUoAgWqjHmXE/Oo;25:qzYM96JN6wsbWPT4w4qsCGx2+8pSGGzZKrWX9N9vgNbOk9vtCULZY+3NPBscF/fNjumC1xAqYz7Lm1mLsmtokTWXSR+2vZG3bqp5vrX+AmeorUUNLtEJDA+19F5vNLOmebTsUXtY3JIBw23IjMTGoJgL5873y2EvM48n0Gtf/5bVAPYZikkdhCYEedDn9Ge0MVnk5DBbUpjT0DhkTbpeXxym4/GKblGoqdQohDXFYpIACsSsMJwLMRMpkr4mMRyna5iG8KDMuNvFS1iSzLI0uKOIM3jLSK0eFFSh3trwlYZ/FHLwhayBfiwmhfVRyH/cKy51U6kHRtBAeDL88GcHnQ==;31:e4BQmJOTIVs5jDLbyMwQPE5tiMQj0S90n9HHyDKq4WjxKDp2v9fBr1GDY+kzEWBSHNMqzBt1pckqOxumlU2LdSL2cO6LdDDG8hVnc+jvCFXn8qbrowpyQ6Ak4yWr/+VZgeLRmPV/oOmlLTXoPzmUzlvqPCUHEPSTM+hXrlguIJFhYf6g5nCN0HD0c0cGk7bhf2KgbRXAnofDNEDHUdmKxRYJ395CrYKO9NSRwtVv8cE=
X-MS-TrafficTypeDiagnostic: HE1PR08MB0745:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB0745;20:mOoaU0/9KhRm33it0woiLyOhRbLfsCdZtqKE7GWhI24rvPHiBMdSQreXS4N+Xi20s8YYDHzWCAc7oSdndD4hhGpetds0XPC1ZAvGMV5QDz/+UgoTDU6bhaV2Ft/g58IFrjz9vdi1PwEJFULPcPFGmUU3q7ZMYd8Qjwy7qa6+HB1dIsWLQ8MLbRs5y2hX+aeG8ncwLRau7t5dwu3vqCsk0iK8GfDsEQ1fkzhyAipytqgRSrdctJTLjRJ8Yw+7OG2YijJXlkokozagJYK1Gw8tWTOb+JeTnflCgrp4Vxh6DSSTTPH43cen8UqSML+0CVZAtxdSC3ZCCsKMCgIWOmwlS0ztx94Wt+Woe65N3E6OZGV9rFLG0xdFi0KyRl1LOHYRdWLQLfwy2yBqjYorXmiKMKY34voffsJeBik4VhQj/0x/PbxUYReDL/RnXq4aVRrd9fGyBMSYbxHk4QPnNXdJoLO7u6+z2vx+DxoKt06ULjSxfAz8miWncnopWwUwsu7n;4:6M94ojZ/8vRabCeuJF8hZWIp16Lg15smasLx4hh4kHOZdWqS1Hvdcpdp6qzfrhTmebHN3iq+cG5JAnHpHzNXhM3t/bH/RNLmxNteROps5a490+izvx/+uheFf9LHG1o7+hB3YCVHm3s1cPySt8zYhKAdQ1A6s3mLJwHl2jbadjDlx02CoEyBeITaiU5l3G78sHotyFsqUtX3KQBxxgCWKMvCwMvva57gKwYuvZcvQzKtgPeRvjEiPuzYKtmTybf2y2Wui6F37KtTiFzMfeUo5BcaT3zHnn6IuMEM1MTzYqkNz/M3K2AoU6EyVuaknfYM
X-Microsoft-Antispam-PRVS: <HE1PR08MB07451655678C6400F1353BCACFF60@HE1PR08MB0745.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(251416522907027);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231101)(944501161)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR08MB0745;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0745;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(346002)(39850400004)(396003)(199004)(189003)(55016002)(97736004)(105586002)(8676002)(83506002)(86362001)(229853002)(575784001)(2906002)(93886005)(23686003)(106356001)(33656002)(58126008)(53936002)(6246003)(7736002)(305945005)(81156014)(81166006)(8936002)(69596002)(9686003)(5660300001)(53416004)(16586007)(7416002)(316002)(25786009)(6666003)(386003)(50466002)(6306002)(6506007)(1076002)(3846002)(6116002)(47776003)(16526019)(66066001)(186003)(26005)(4326008)(6916009)(7696005)(68736007)(2950100002)(52116002)(478600001)(966005)(76176011)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB0745;H:outlook.office365.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;HE1PR08MB0745;23:tGZZwa+dW46Ztmn6/d6AnasmPGZQr0yC9CqSY11UoJ3?=
 =?koi8-r?Q?Y/GWQm31q1OweoMABHsdBjJdj+ce5Y99HDhKtzB7752vKn+7SkynfyIbwYMLHj?=
 =?koi8-r?Q?d1nbz0cxokVvOixiPIQf6Ww4Z3m0CzxC5aJPUvJceRn98R55VSj2GFF/eT5RvJ?=
 =?koi8-r?Q?5EUCbBvzjtvSCtGPnxBlwrpnaebKvTQZoevPltO52pzDAU21Y9ajLDYSLIkMZR?=
 =?koi8-r?Q?zUT33QFIKTQpi/C2+5D4zdI131uSE+isgU6KajpVLYH/UCxWHlL5NeW21L+xc+?=
 =?koi8-r?Q?7AMS9hncqbFLF0q8FEpve9yWtvUGcsS7+z7dcPe4rYscypQNYdn2evayD4yAx4?=
 =?koi8-r?Q?nM873xkW6rZkMGUAui3rDELGYXVAwmqWC6LBPEMBXd1iZbRmdt3tB2HH0bradu?=
 =?koi8-r?Q?HdkEktNBGW98daTnGR8gEwXe2e+1w6ujdlBUEkz1tBO8MFhLiC4t7/qBa6/wSg?=
 =?koi8-r?Q?O2iqS1q51nlFBxMw9UmQBe1MjSOXwtn+EUGMNrUYNOySIsJ9XEo7RJMBYuACOD?=
 =?koi8-r?Q?AGTF7l7wwRZhUIBmdpY/0Ut8SJhIjvawp6V6Fn18YIdKD+Yi6I+M/edp02s/AR?=
 =?koi8-r?Q?YDXCuOzcM1/1mVPpsm9hThckix39Bk9fZgoXbbJZ8KQc7wasOrxKPONso9yoKX?=
 =?koi8-r?Q?2uLLEeWUni034o8HPS2ziJ8+pJ4zWD+1Mb0dFjPk+hQXKgb1DsiERhHFg1YoHN?=
 =?koi8-r?Q?G11rp4dnmJLESi4VAKRcI9XUDZ5GS0kspEH69gp12yqXIlomF5cvs5IJebs4wH?=
 =?koi8-r?Q?kFm5Tv1CeGD20sHxxDFwRjlvi1mNe+M0RBqLeuZ/2ZrZ2pbSgG7EpQOggC4cjz?=
 =?koi8-r?Q?yTPpaa4jiWDbLbETDobStRWzTBFpwfofgobemab08J6H92Mhd/KqZMS5uoxgbZ?=
 =?koi8-r?Q?k4Y5D6a1+Q3AzpHCqnoYaxYSSsAKyxdIa2DGQuplNe/+yH+DrKB1rSpuYsRwOD?=
 =?koi8-r?Q?tk9w8yezyBPMUX2py3lCp9/0xpI0OatdPL+hsPp1By8Oy7QyTu3D2VG5Keeg9i?=
 =?koi8-r?Q?YuX2oEkIctXuoLXuEm8ZVLQz/lkse17Ha4Z2H9PRuub6uDouKbhlDr87deNCKM?=
 =?koi8-r?Q?frKj71rcyTwLycXBxENdp2zXPgSiu1+9UHrfQz4Q+M5RCtv+fFTlM/IyWr556E?=
 =?koi8-r?Q?jyYTsbXin/VCN1CmYugk1o0Y/NErOq7Pun78suqwcgbH3n8I/WlKOpFwdYAlty?=
 =?koi8-r?Q?+Z139lFVPplHpEuphNe5DMr1hpYFky1aLurdFhx+jvTYRJOrf3KjgBdheK9zyD?=
 =?koi8-r?Q?d9wgSt62N2qxM/+0L/mfqvSQH2npVdDmpNRoh2gpjBRKgJeYeR+6kSDMdT2s3U?=
 =?koi8-r?Q?WzAtssMM4Iewo9+a/lTrQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB0745;6:n6BWLQhoIz3vvVcIxi1mVEOyFySygB3/rcB0C0gTzK40VxBdMZRxfflupn5HeX/9RYamgEgWmu5HxOcBfUOOFMRQ3VHGMLokgc6X/bWI++w9CGFxoFmEzPEtzf+f4NkdjC0OjrbnS+P4fA199brTPWsLP3Xljr5de2JROBtH6xdewPmSUmA6cNOmzegGhODr11px4Xo7cmFQDaR8O+5O7DUKIsLlrgUOypCFCPOp2pEzsoit1ODKRcrp9Rb1plUtWWLhbGl9pS/PiU2oQq9OYCWNPLZ0/zmpHzYKskqKNmemTExk1PkgKiVRZ4olZjyjH/CUMHozWgzRXA3X1R8CXJh42KiY8rwyXxw/UNM/NJY=;5:9Qom5bghHxs3wVu43QuH4y9tcfRetB1wn+ZEkWAocM2JuYA27RxBZOtyozR/mpdwaNknl1fpl/Oi1wPuaykKaaBrgaWLYRv9EQqqo3JYKTNt+jcMc1I3q4o1d6aw6YFr2x6p0VPgMQVqz+bZChvfkEQ+lGUeFA65h5mCsFixY0M=;24:SM0EZiE8XvBkNcbbQBInlsmVpKVUvK6XG0oqBONefgraYUD9nUWziIulRIgbPt9YePTQ4kY6OHeHPxdQUnZJPz4eJvbg0JLMPnxjEAniZb8=;7:H4/yFmEZCdEeJPPBV7FQ9JjB7bWxUo0V4803qmelnTofnLLSYgH7rmsezo9rKCl+C2cnYNgbqyflfB/sAa4QaFQch/n0DqjtKUa5WUf7bLIis8dNKe2n14jMsmTx/Pp/mfUkxvdS1K4vQuUM+ZnCoROVNyetX68iHdh1aro1hS6sogiyWb/gqjV72KmJbhrZL+rgZFlZbUQLgqZovqWMZuhof+8A5pqDCH7C6pneIKMu2GLyHt2onSrBHxJ7jyfK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB0745;20:bInhY7K5OdNZ+x9WCwlswqM4GL0gS8vGOuYubzUcxy1/c6a5KQEb0fm9APOTHSs1XZLoB5T/0DKe7jwuyY5CDAc/WkV63RdoOxqk4K9cflfviP5pI8SxozWqwfmOaAJMC/9Td+wDp/E48dXDRamnS80p7EPyq6XdpwGp9ljvNp4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 16:53:50.8092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ef4f39-04a7-493b-3c4e-08d573025ded
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB0745
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 12:02:49PM +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 13, 2018 at 12:41:22AM -0800, Andrei Vagin wrote:
> > On Tue, Feb 13, 2018 at 11:08:16AM +0300, Kirill A. Shutemov wrote:
> > > On Mon, Feb 12, 2018 at 10:51:56PM -0800, Andrei Vagin wrote:
> > > > Hi Kirill,
> > > > 
> > > > Something is wrong in this patch.
> 
> Could you please check if this makes a difference?

The kernel booted with this patch. Thanks!
https://travis-ci.org/avagin/linux/jobs/341030882

> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 70b30f2bc9e0..99a0e7993252 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -332,7 +332,7 @@ ENTRY(startup_64)
>  
>  	/* Make sure we have GDT with 32-bit code segment */
>  	leaq	gdt(%rip), %rax
> -	movl	%eax, gdt64+2(%rip)
> +	movq	%rax, gdt64+2(%rip)
>  	lgdt	gdt64(%rip)
>  
>  	/*
> -- 
>  Kirill A. Shutemov

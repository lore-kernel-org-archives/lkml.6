Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974C1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BB8208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gKZPny6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BB8208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeGaMns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:43:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48944 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbeGaMns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:43:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180731110359euoutp02db9494f0be8584958ebd9a97d3d86145~Gbz75UGAE0260902609euoutp02C;
        Tue, 31 Jul 2018 11:03:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180731110359euoutp02db9494f0be8584958ebd9a97d3d86145~Gbz75UGAE0260902609euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533035039;
        bh=5fFlWPkNoRPeZqXn5dH4QX7OnT0dopg3Gdke4CaHp6c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=gKZPny6s+XYSi7m625PfqPJyheU1lCtPjSbery3Iq7sF4l1ebAAiayRbVzjcNQfBL
         ugT/nZy8M7W+km+9spp906RnRTRBbF8qjRBjWxLSIn+dvniLitSJB8LnQnHnDhXl79
         E+0EH37tfzfNgzhufwpTqCqW3ocWiRMzJ/xOXSg0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180731110358eucas1p1c1655e8c290fbac71dfec79225636951~Gbz7TZd0g1167511675eucas1p1K;
        Tue, 31 Jul 2018 11:03:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2B.C3.05751.E12406B5; Tue, 31
        Jul 2018 12:03:58 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180731110358eucas1p1bea0cc75c40691f010204dba293ee52b~Gbz6mhT6W2761727617eucas1p1V;
        Tue, 31 Jul 2018 11:03:58 +0000 (GMT)
X-AuditID: cbfec7f4-077c59c000001677-06-5b60421e53ad
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.96.04183.D12406B5; Tue, 31
        Jul 2018 12:03:57 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCQ00LZ99ELG880@eusync1.samsung.com>; Tue, 31 Jul
        2018 12:03:57 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     Mauro Carvalho Chehab <m.chehab@samsung.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] media: omap2: omapfb: fix boolreturn.cocci warnings
Date:   Tue, 31 Jul 2018 13:03:57 +0200
Message-id: <1621309.sZUdEDiQYq@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180725175700.GA82131@lkp-sb05.lkp.intel.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOV05p4Rog/ufFCxe/5vOYnHl63s2
        i/fP1zNbHLs+kdniRN8HVovLu+awWfRs2MpqMXtJP4vFxXXyFuvn32Jz4PK4v5fdY/Gel0we
        97uPM3l8fHqLxaNvyypGj+M3tjN5fN4kF8AexWWTkpqTWZZapG+XwJXxc8889oLXrBW7P6xm
        aWD8wtLFyMkhIWAisbWtn72LkYtDSGAFo0RXVy8LhPOZUeLE+e/sMFXTtnYzgdhCAssYJRp+
        +0DYvxkldi0SBrHZBKwkJravYgSxRQT0JFYsbGMEGcQssIlJYt+qU2CDhAU8JL6eewG2mkVA
        VeLIsr9ARRwcvAKaEq/myoCERQW8JLbsawfbxSlgI7Hp3lJmEJtXQFDix+R7YK3MAvIS+/ZP
        ZYWwdSTOHlvHCHHnfTaJwxMFIGwXicZnF6G+FJZ4dXwL1C8yEpcnd4M9KSEwnVHiza+lUM56
        Rok1Z44xQVRZSxw+fhFqA5/EpG3TmUEOlRDglehoE4Io8ZB4vm4SOyQgDjBKdG/ynMAoMwvJ
        rbOQ3DoLya0LGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKaO0/+Of9nBuOtP0iFG
        AQ5GJR5eD634aCHWxLLiytxDjBIczEoivDYyQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8d/rj
        ooUE0hNLUrNTUwtSi2CyTBycUg2MvvLfnPfLnvn0+OCV85H+wUIZvJ03xKsCgreuvl0a0dOh
        enaFVabn6kdXeJzXJ+3IeTz17LFfq9MDzkzOD7JeL139qPm52wQjFUGL9Ws2vxbaILV90kz9
        Y50Jf//aFIftL77ooZKsfWeFF9+E3wk5acu7xL7smrFb01Tx/LXqF6Xedu25yYxTlViKMxIN
        tZiLihMB7wZJaxkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsVy+t/xy7qyTgnRBgenWFu8/jedxeLK1/ds
        Fu+fr2e2OHZ9IrPFib4PrBaXd81hs+jZsJXVYvaSfhaLi+vkLdbPv8XmwOVxfy+7x+I9L5k8
        7ncfZ/L4+PQWi0ffllWMHsdvbGfy+LxJLoA9issmJTUnsyy1SN8ugSvj55557AWvWSt2f1jN
        0sD4haWLkZNDQsBEYtrWbqYuRi4OIYEljBL/plxmhnD+Mkqs37ecFaSKTcBKYmL7KkYQW0RA
        T2LFwjZGkCJmgU1MEp8vb2QDSQgLeEh8PfcCbCyLgKrEkWV/gYo4OHgFNCVezZUBCYsKeEls
        2dfOBGJzCthIbLq3FGrZAUaJG8evgSV4BQQlfky+BzaHWUBeYt/+qawQtpbE+p3HmSYw8s9C
        UjYLSdksJGULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBAb/tmM/t+xg7HoXfIhRgINR
        iYfXQys+Wog1say4MvcQowQHs5IIr40MUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB
        9MSS1OzU1ILUIpgsEwenVAPj/qIG643hr19V2JcW/mrUOKDpGVodeCOiYemz6vNZvoFztA/d
        Xxny+sEvl3VfJp2c5BCj0uh98EiCnFW8pMzCiQpzbXR0GtbwrDGPkqmP+O3PlnnodfbO94r/
        1/Nx6TcuY/3leEX9ou0/rXler7f7Pi7KWfht25MT62Pvb3i7te3CyjV8scpTlFiKMxINtZiL
        ihMBnDRNo3oCAAA=
X-CMS-MailID: 20180731110358eucas1p1bea0cc75c40691f010204dba293ee52b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180725175735epcas4p1bd4f49c171946156d847d643a6ea22c0
References: <201807260144.q4WK2PMA%fengguang.wu@intel.com>
        <CGME20180725175735epcas4p1bd4f49c171946156d847d643a6ea22c0@epcas4p1.samsung.com>
        <20180725175700.GA82131@lkp-sb05.lkp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 26, 2018 01:57:00 AM kbuild test robot wrote:
> From: kbuild test robot <fengguang.wu@intel.com>
> 
> drivers/video/fbdev/omap2/omapfb/omapfb-main.c:290:9-10: WARNING: return of 0/1 in function 'cmp_var_to_colormode' with return type bool
> 
>  Return statements in functions returning bool should use
>  true/false instead of 1/0.
> Generated by: scripts/coccinelle/misc/boolreturn.cocci
> 
> Fixes: 7378f1149884 ("media: omap2: omapfb: allow building it with COMPILE_TEST")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

Patch queued for 4.19 (w/ "media"->"fbdev" fixup in the patch title), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


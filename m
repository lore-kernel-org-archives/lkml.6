Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-583015-1524062392-2-18308310796704881201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='no',
  MailFrom='org'
X-Spam-charsets: from='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524062392; b=u4MYKNYmoZ50zmkSDI1JBNXz3TOg77SYVLs039uRe4abJoHjJI
    9u6W95LBce8nCtKqPLr5M2pk6AclvZxPw2zJwniArqcAwQkRfw5ivpjUVTwTYT+3
    b/5rNU2UmGXEEXLch2AHHpAy3nQTXw5elX/oBiJAMZUt+37ctXODqBN4RRjtLQ95
    jK1vF0+oJurofCK7a9zCsOl0Lw6vsXns2/1m7oV1yKM1xQ57Nah+NR9K7bPekKGj
    29GxmKSa+3TguEXAZeBOd1qhdT0kE81lqcNm1lSrz2uWyT+Omao2RuVV3hY4qHV8
    Q1YSkGi3czkxbC8fAN8dYqLzOAuTidA4YVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524062392;
    bh=ke2oY0TQPMAjtBC2eBOTNMAhifc+jWuKFrGL0SEGffo=; b=GLYOYvqaXqR7
    u5Pz56fxEAqXiPLfoNUsWyp1IxeeGsHG/slhRBrPQYqdYiG1PwyeyVgamLpkxxaH
    bSEfvnwzsDlAiyFKn9tRgty2ymTECOyfYyMpNF+8CsChV8qe1E2GHtS/z0Ciiu7Q
    iAOykGqj5ZYUAs8pENYIda3W39Sbqk8/WJlEyoa5Eg++Lw3X0g1sup87lk5bKla6
    VF2iP8pdx4BCyNZppgdqtil2Phlx2ssWF30wv86yavpBjysIXzotGqltIhPtBnk5
    LcdXL9KsizroA4iguQqFAi26B2cGoNDnnzEPWgq6I4eumTVGpKZpyMNN7XlRsevc
    dp7wuAbWSQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=mork.no header.i=@mork.no header.b=i3ODV7rL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=b;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mork.no;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mork.no header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=mork.no header.i=@mork.no header.b=i3ODV7rL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=b;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mork.no;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mork.no header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPnRBHzEiDBqSXYEF6RMAjj2BiCGORQxwtjpRmwqGZXMXFE8W8XpNHZLZWVpr4dpCLjXxXsqObnSx9ATiytcQMgCF7YJaF8vh1WvDu+9eJ7mGXmIeIyC
    TuNeXJKUzT1KJsiV2WChuKKC0ftI3x4gQ/xOayfixtOSgnyD2hjALbjDMycg5q0pjMDJoskp4peCpqMJLmSGUagyp8ra+/EiANZHMS+kdO5FL5+Wg+jZr3Pq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=rq7REQFhPMCXMozBH4QA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeDROje (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 10:39:34 -0400
Received: from canardo.mork.no ([148.122.252.1]:56061 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752659AbeDROjc (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 18 Apr 2018 10:39:32 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qmi_wwan: add Wistron Neweb D19Q1
Organization: m
References: <1524060204-7814-1-git-send-email-paweldembicki@gmail.com>
Date: Wed, 18 Apr 2018 16:39:05 +0200
In-Reply-To: <1524060204-7814-1-git-send-email-paweldembicki@gmail.com> (Pawel
        Dembicki's message of "Wed, 18 Apr 2018 16:03:24 +0200")
Message-ID: <87d0ywefzq.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Pawel Dembicki <paweldembicki@gmail.com> writes:

> This modem is embedded on dlink dwr-960 router.
> The oem configuration states:
>
> T: Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D 2 Spd=3D480 MxC=
h=3D 0
> D: Ver=3D 2.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D 1
> P: Vendor=3D1435 ProdID=3Dd191 Rev=3Dff.ff
> S: Manufacturer=3DAndroid
> S: Product=3DAndroid
> S: SerialNumber=3D0123456789ABCDEF
> C:* #Ifs=3D 6 Cfg#=3D 1 Atr=3D80 MxPwr=3D500mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3D(none)
> E: Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E: Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driver=
=3D(none)
> E: Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E: Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3D(none)
> E: Ad=3D84(I) Atr=3D03(Int.) MxPS=3D 10 Ivl=3D32ms
> E: Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E: Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3D(none)
> E: Ad=3D86(I) Atr=3D03(Int.) MxPS=3D 10 Ivl=3D32ms
> E: Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E: Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Dqmi_wwan
> E: Ad=3D88(I) Atr=3D03(Int.) MxPS=3D 8 Ivl=3D32ms
> E: Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E: Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3D(none)
> E: Ad=3D89(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E: Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D125us
>
> Tested on openwrt distribution
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>

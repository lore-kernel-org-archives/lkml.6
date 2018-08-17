Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434A4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45102086A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j7seAhoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45102086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeHQG32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:29:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:12009 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeHQG32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:29:28 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180817032745epoutp039990def0a09ef235a406def4be89eb0e~LjjckYhMv0180901809epoutp035
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:27:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180817032745epoutp039990def0a09ef235a406def4be89eb0e~LjjckYhMv0180901809epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534476465;
        bh=gyK0CmDi+128aP0+H8woV758jZRgiopkL9ZjGnOVPx4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=j7seAhocT1yDAgK1wWz7CJwUFIlYqUUsVzDMvlYdOgQXHigunUbznPjJ7hXGN6eOt
         KU17SvnXRNF6JHVkfrsK8kLNojfdF+sxhfoYgVlYVBNCAl6YTwXQDrvrQlHWq92Oqt
         LToMu33cnx0o76ZkVWmH7cRnIGLmIdrhl793yn84=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.196]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20180817032743epcas5p49542167d7083dddd2508f70a43eb7a4b~LjjbA41Jf2468124681epcas5p44;
        Fri, 17 Aug 2018 03:27:43 +0000 (GMT)
X-AuditID: b6c32a4a-9b3ff700000010d5-34-5b7640afe53a
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.23.04309.FA0467B5; Fri, 17 Aug 2018 12:27:43 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/1] Preventive patch in the proc file-system to
 handle NULL check.
Reply-To: srikanth.h@samsung.com
From:   Srikanth Korangala Hari <srikanth.h@samsung.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Srikanth Korangala Hari <srikanth.h@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180816123223.GA15817@avx2>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180817032743epcms5p1f185381607d99cb8509c174dcadeb754@epcms5p1>
Date:   Fri, 17 Aug 2018 08:57:43 +0530
X-CMS-MailID: 20180817032743epcms5p1f185381607d99cb8509c174dcadeb754
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTXXe9Q1m0wdT7BhbTG70sXh7StDjT
        nWuxZ+9JFovLu+awWdyY8JTRYseLV0wO7B6zGy6yeOycdZfdY9OqTjaPvi2rGD0+b5ILYI1K
        tclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYqsUbWhopGdoYK5nZASkTWOtjEyBShJSM/5eri44zVSx
        ce8DxgbGA0xdjJwcEgImEse3TmPsYuTiEBLYzSjx4fYJti5GDg5eAUGJvzuEQWqEBWIlfl3f
        zQgSFhJQkLi1KhoibCExaUYnM4jNJmAm0fN9D9hIEQFNiWN3N7GBjGQWmMYksefxbqhdvBIz
        2p+yQNjSEtuXb2UEsTkFtCTefupghoiLStxc/ZYdxn5/bD4jhC0i0XrvLFSNoMSDn7sZYea8
        PzaFCWSZhMBkRomvP3eyQDirGSX2H3oBtc1c4vHNzUwQj/lKLJkVCBJmEVCV+NvazQwSlhBw
        kTjQYQASZhbQlli28DVYmBnomfW79GHOb9j4mx2dzSzAJ9H7+wncizvmPWGCmKgi8WB/GYQp
        JdH7yQ6iwkPi9a1O5gmMirMQwTwLydpZCGsXMDKvYpRMLSjOTU8tNi0wykst1ytOzC0uzUvX
        S87P3cQITodaXjsYl53zOcQowMGoxMM7YW1ptBBrYllxZe4hRgkOZiUR3pnngUK8KYmVValF
        +fFFpTmpxYcYTYH+n8gsJZqcD0zVeSXxhqZGZmYGlgamxhZmhkrivB/8gqOFBNITS1KzU1ML
        Uotg+pg4OKUaGMtPxj2Tjvy5b12PfPOK2+umO8Ql86bf0OUK6Etd47m79mHPNo2N61i4dgVO
        FGupC1x9a+qHu4uZd+ev+dFi/XhTM0/Wi5Sas1ohJ4INyk127HsrFFlYJOt1+XFo+bdv8puO
        52+qD/j1XH9HHffzb43BLVtlOz3LXFwEhVlXtGZmTkv2C6uZrcRSnJFoqMVcVJwIAHQHC6Cd
        AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180816093424epcas2p25ede075fec715ad31108360ddca9cce8
References: <20180816123223.GA15817@avx2>
        <1534412053-22457-1-git-send-email-srikanth.h@samsung.com>
        <CGME20180816093424epcas2p25ede075fec715ad31108360ddca9cce8@epcms5p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It=C2=A0is=C2=A0fine=C2=A0to=C2=A0crash=C2=A0because=C2=A0/proc=C2=A0is=
=C2=A0not=C2=A0modular.=0D=0A=0D=0ADear=20Alexey,=20this=20was=20theoretica=
l=20solution.=20If=20you=20feel=20this=20should=20crash=20instead=20if=20th=
e=20call=20fail's=20then=20ignore=20the=20patch.=0D=0A=0D=0ARegards,=0D=0AS=
rikanth=0D=0A=C2=A0

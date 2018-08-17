Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE80C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9255F20852
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MWOQBzx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9255F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeHQGX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:23:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:14216 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeHQGX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:23:26 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180817032144epoutp020c11eeb42a0dbe9cd9d60454a2b7c09a~LjeMtFoeB2646726467epoutp02j
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:21:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180817032144epoutp020c11eeb42a0dbe9cd9d60454a2b7c09a~LjeMtFoeB2646726467epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534476104;
        bh=lnKmwkqyR/cXESlbEZoxKYvASV19Kjnouy381ShIhOo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=MWOQBzx5KjHKaoswhhat+PFsbXFfIfbStjHmm3vzXdU5E3IJoUn93kDkRZwByy7yr
         X0dARX+IPC02r8KAULpQiLxd7oMcMby0lKSi71r3guiKBkxCXEJUETyUZqZq9zy1ql
         ntZ34i+S50FlYv1EI0YSM4NwIkeARvMmBQ8vTir8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.195]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20180817032142epcas5p4b8b9f929274fdb66078730e3276715ac~LjeK14q3M2087220872epcas5p49;
        Fri, 17 Aug 2018 03:21:42 +0000 (GMT)
X-AuditID: b6c32a4a-9b3ff700000010d5-86-5b763f467d50
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.02.04309.64F367B5; Fri, 17 Aug 2018 12:21:42 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/1] Preventive patch in the proc file-system to
 handle NULL check.
Reply-To: srikanth.h@samsung.com
From:   Srikanth Korangala Hari <srikanth.h@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Srikanth Korangala Hari <srikanth.h@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180816131731.GB1457@garbanzo.do-not-panic.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180817032142epcms5p875c72643ea624e3b2d8f10e4abaf5182@epcms5p8>
Date:   Fri, 17 Aug 2018 08:51:42 +0530
X-CMS-MailID: 20180817032142epcms5p875c72643ea624e3b2d8f10e4abaf5182
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTU9fNvizaYNlaU4vpjV4WLw9pWpzp
        zrXYs/cki8XlXXPYLG5MeMposePFKyYHdo/ZDRdZPHbOusvusWlVJ5tH35ZVjB6fN8kFsEal
        2mSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3aCkUJaY
        UwoUCkgsLlbSt7Mpyi8tSVXIyC8usVWKNjQ00jM0MNczMgLSprFWRqZAJQmpGT3X37IX9LFU
        vDh0lbWB8T9zFyMHh4SAiUTjx7QuRi4OIYHdjBL7Ly9hAYnzCghK/N0h3MXIySEsECvx6/pu
        RpCwkICCxK1V0RBhC4lJMzqZQWw2ATOJnu97mEBsEQENiX0TeplARjILzGKS2P7+FitIQkKA
        V2JG+1MWCFtaYvvyrYwgNqeAncSi05/YIOKiEjdXv2WHsd8fm88IYYtItN47ywxhC0o8+Lmb
        EWbO+2NTwJZJCExmlPj6cycLhLMa6JlDL6C2mUs8vrkZ7DxeAV+JGzPXgG1jEVCVeL56E9Q2
        F4kl5x6BxZkFtCWWLXwNDiBmAU2J9bv0YR5o2PibHZ3NLMAn0fv7CRNMfMc8EBsUtioSD/aX
        QZhSEr2f7CAqPCRe3+pknsCoOAsR0LOQrJ2FsHYBI/MqRsnUguLc9NRi0wKjvNRyveLE3OLS
        vHS95PzcTYzglKjltYNx2TmfQ4wCHIxKPLwT1pZGC7EmlhVX5h5ilOBgVhLhnXkeKMSbklhZ
        lVqUH19UmpNafIjRFBgAE5mlRJPzgek6ryTe0NTIzMzA0sDU2MLMUEmc94NfcLSQQHpiSWp2
        ampBahFMHxMHp1QDY0PHE7WUSb8U2SwT+FyZN1iGu3Z52q+4b3TmZsa0HQa7a7Zzqziu/BTt
        zresp1X8bezpeCXGiwUXDlb9cmCx9Tg2p/oNX4Lx05LIzW9T/n7ZkLeO/aJCb1CubkDZk7sd
        Us1FQYdcvKr0O9yWB5zLPvVz965Qp99dzKXrEyRv+FXGHbbvCzNTYinOSDTUYi4qTgQA1jg3
        Np8DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180816093424epcas2p25ede075fec715ad31108360ddca9cce8
References: <20180816131731.GB1457@garbanzo.do-not-panic.com>
        <1534412053-22457-1-git-send-email-srikanth.h@samsung.com>
        <CGME20180816093424epcas2p25ede075fec715ad31108360ddca9cce8@epcms5p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks=C2=A0for=C2=A0the=C2=A0patch=21=C2=A0Do=C2=A0you=C2=A0have=C2=A0a=
=C2=A0reproducer=C2=A0or=C2=A0is=C2=A0this=C2=A0theoretical?=0D=0A>=20This=
=C2=A0will=C2=A0affect=C2=A0if=C2=A0it=C2=A0should=C2=A0go=C2=A0to=C2=A0sta=
ble=C2=A0or=C2=A0not.=0D=0A=0D=0ADear=20Luis,=20this=20is=20theoretical=20a=
s=20I=20observed=20in=20most=20of=20the=20call's=20to=20api=20-=20=22proc_m=
kdir=22=20the=20NULL=20check=20is=20being=20done.=20Hence=20I=20thought=20o=
f=20adding=20one=20here.=0D=0A=0D=0ARegards,=0D=0ASrikanth

Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34BBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995372088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995372088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932921AbeFPTWH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 15:22:07 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49530 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932542AbeFPTWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 15:22:06 -0400
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w5GJM5pZ014504
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 15:22:05 -0400
Received: from mail-qt0-f197.google.com (mail-qt0-f197.google.com [209.85.216.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w5GJLx7u029381
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 15:22:05 -0400
Received: by mail-qt0-f197.google.com with SMTP id f8-v6so10243380qtb.23
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 12:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=is4zO7ln1VF+El6V9as5g/4MCpyFZT3CdNAvjFzRByI=;
        b=kq+gBv6VVulNBOqFA3nARiXmq8294cNMQBiPAZaPUmI1n+ILKPRkT1Ho9voPpRw2Nv
         CAbzeaxUKkBDsrMJLk4J5tdqRWhgG4P2yoRfHRfhgurBM+dlSmZtTUqur7bQqf8hpel7
         e3q6Qirql6FdHXbyBOJmDXFLF05IUueZGEVwIy5YgcL/fm9yO+ai0IHGUr39JAbTOe5v
         96YzTTiOk9yjYXiYQKhIRMtNCsZ9uT7pVTF1H3e4TM0axccJ+rkCs5+QptyUhmgHJRGI
         pFwnpsM/n1YOnezqNYQhNQ5mpcgU2+XploriU2x92hpRASoq9w2DHb5DP13i98L7NdZW
         mHkQ==
X-Gm-Message-State: APt69E1H6h3uKnuRCMXcc8QfnNClK8ZmvLsV6Xiz2M4D+Et19hEHjTgq
        Qmh2CxzVWFUwrxRuaLR+zoIPUX/LmCZRVzlQTuqDEV139NlxQWJ+uxhHFAcPrF4h+ctJsWIL244
        QTqcpr3oM1wKOgKd519Sq2msokJk90UliL7w=
X-Received: by 2002:a0c:b3d5:: with SMTP id b21-v6mr5694894qvf.80.1529176919791;
        Sat, 16 Jun 2018 12:21:59 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKI8/y0UMY19LqdcAOxUz7/UzdG8bWCMZBU6S8043/Pah4U70NHLUZsly2zRa+JCq4CAefFQfA==
X-Received: by 2002:a0c:b3d5:: with SMTP id b21-v6mr5694881qvf.80.1529176919576;
        Sat, 16 Jun 2018 12:21:59 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:2116:22ff:b17b:7cd6])
        by smtp.gmail.com with ESMTPSA id 73-v6sm11051031qkc.96.2018.06.16.12.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 12:21:57 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Hyunil Kim <thtlwlsmsgkfla@gmail.com>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        colin.king@canonical.com, johannes.berg@intel.com,
        Linyu.Yuan@alcatel-sbell.com.cn, keescook@chromium.org,
        tvboxspy@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: fix line over 80 characters
In-Reply-To: <1909265.MoDodiKBI3@os-virtualbox>
References: <1909265.MoDodiKBI3@os-virtualbox>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529176927_2593P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 Jun 2018 15:22:07 -0400
Message-ID: <127735.1529176927@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529176927_2593P
Content-Type: text/plain; charset=us-ascii

On Sat, 16 Jun 2018 15:00:31 +0900, Hyunil Kim said:
> *fix checkpatch.pl warnings:
>  WARNING: line over 80 characters

> +		if (((ieee->wpa_ie[0] == 0xdd) &&
> +		    (!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) ||
> +		    ((ieee->wpa_ie[0] == 0x30) &&
> +		    (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))

Ouch. The && and || at ends of line mean a lot of parenthesis counting to
figure out which goes with which.  Use additional indentation to help
understanding.

+		if (((ieee->wpa_ie[0] == 0xdd) &&
+			(!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) ||
+		    ((ieee->wpa_ie[0] == 0x30) &&
+			(!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))

Or perhaps

+		if (((ieee->wpa_ie[0] == 0xdd) &&
+			(!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4)))
+		     || ((ieee->wpa_ie[0] == 0x30) &&
+			(!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))




--==_Exmh_1529176927_2593P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWyVjX40DS38y7CIcAQLvQAf+OBGixusBCtq3aYv/IdQD8vBY1K6UAT/m
+UGkFJ/vG6ZBn6j1LcnCpw2ylMho4zGcsIOHNrBLok3P20NSQWcqEGOlXAsgA1Tq
ZZuEiHC7sViWcTYJ9pxwZj3bcXVLu9eU5ba2Q+OoHpB0Gvs3PpD6AW6PyJifFnl6
xEVbHwMS5A128WR/+yKmHfg3GW0z/Y+R0dglD9PMsxfvtnK+ntQ29ALvoRTOJdl6
xcueIXASGFX98rAdck5NR/uZyMeyXd8hRf85xyb6r017D7zLQ4K1I0rIV8fFw9hX
KjoKUlk+uOVidXxhG3IvNWET0Aom4rF5KGWgOJjZ35iQgxmT9yawag==
=ROkq
-----END PGP SIGNATURE-----

--==_Exmh_1529176927_2593P--

Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A403C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3F42082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="J81faT2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3F42082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH3UQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:16:38 -0400
Received: from sonic317-47.consmr.mail.gq1.yahoo.com ([98.137.66.173]:37788
        "EHLO sonic317-47.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbeH3UQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535645625; bh=ckgpfzHItGO2imlxSVQE63TRi9gh2uV/Zkss2My7vEk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=J81faT2EnEuqEaTQOwEQYtVxYMvimIqxG4I1VH+v70pyUp/bYyYJ5Rb3N7Y/k7Sm8PmapqT40KlTxJpaNQ1Yd41T/+4yd4vWhXS0Y8umjcBn8xjCIWhKqUC/e5Pb0BZl+rWpXdo/Hc9YOc7NmUx3cziitshvlMaiQ2DrxfpGbwJIB64KNf0U4IkzUYWGCZ5UUC3xxKbNCSJp05GFcmzw/6FrXvA9ETncGkhJhZh9lL3Zvt+hy3S0Tf25cIbIqew7R5q5bdS11kLeuRYPpnZo1fn22NuL9OnJPuXlio4bEjQxT7GBy91o2OmeHtKDiwuzz3ouckrCuBbgVBCdpVppmQ==
X-YMail-OSG: z2Yc9YsVM1kl56nHF7aCzTqWK0CVsoc0JezNAopyWTJtA61Gojvaeq9qMl5OTIH
 mlOQVvqGf20ocufAax9QocqjN0ejGt7zPoPYijF9.RqyNQuY6NY4U0BC9OwIaLSAsItkEF1PngxY
 ZxF2Fduqhd5dUk4lEiF_pzU5Nc5B.f4uLoYQyhSnNzRstM9hOTeyLfFlY80SyS5qSkTMkUtzvJ_u
 J_FTlhBMmr7xRWAOm79ySMGCEKz1EwYK_ylQIMJOiduU9aOtl6VTdZzmXxZLZPZhDddau3zTG.SK
 1tqsAitZqpccygbtkIQl8V3c_shQp.gc00sRcAoH5n2mCYQT6D5wBWAjzU9iX_BAxXFA6Y7WZGoF
 OmhTZ5JnaAR1pDlvUyD09opjMxd5x3hOjuAngig3kZOzdzjATASQAhdNBwj1DDvG31vySFp68Qbg
 wbs4ly8H03IAWEwzhLQP0sgjB2VbcxtZAiGuiuUFsedeotjFrA2Vv.RARwd0IlC5n23Q4KzTiRMz
 DZYA90_f9VOd_dwjNFKJG6RpEmZLJ_vCxvU5k5.vh5xs1XrU2OuikdozzHcPhaHcYEOvFcJrM8sx
 y8IZk6Ky1hxGQor0lGXBPerX8dinJ2EXf6VQaB6lv6CFR5GT24.1Gv1VC7RwDYQojmsSA9618yOg
 QyfpNco4uOJMkvNW88.25b5L6vbadGs9dhIkq6Qwcin0ElHD6eBMu1aXoyD8RDrFU6eNXdZcN5ze
 UqaPsEPt2lj0BErGZvwZyagJiiMZNTanZKpI20NsOmoDAWkMv_68h_Yae.5zvpCUjEUbZhM8kM7u
 GChLmKHa370xcVnwdCpajgdEI7deggX4ARAvi0pX2coJDocyqTUz7fBhv1ELBz4CVNylyGsqgUNH
 HGDI9YyU0Oe6oCBfgyRzpSCSjd8Z35S1J.HD2.5AJY0CKbc_xazf0CYqVc9zFqAl6gQh3cgshIYH
 yNx3jN9xAP0DbkibegzUHcdYu0iLI3_uwjGkYW_Gbx_5GWPeEoeG7G7bwRhcrZhvVHCuhwOqr0qa
 4HOZn
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Thu, 30 Aug 2018 16:13:45 +0000
Received: from 221.13.70.165 (EHLO [192.168.55.130]) ([221.13.70.165])
          by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 63d332b5bc8dd26913691cd032b9eaa2;
          Thu, 30 Aug 2018 16:09:45 +0000 (UTC)
Subject: Re: [PATCH 2/6] staging: erofs: formatting fix to NULL comparison
To:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        ldv-project@linuxtesting.org, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <1535642042-5336-2-git-send-email-zemlyanoy@ispras.ru>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <747d9c74-02cd-fa39-9870-ae17dbddf366@aol.com>
Date:   Fri, 31 Aug 2018 00:09:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535642042-5336-2-git-send-email-zemlyanoy@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 2018/8/30 23:13, Pavel Zemlyanoy wrote:
> This patch does not change the logic, it only
> corrects the formatting and checkpatch checks by
> to NULL comparison.
> 
> The patch fixes 5 checks of type:
> "Comparison to NULL could be written".
> 
> Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>

Sorry about the late reply. I am on vacation now.

Personally, I use "== NULL" or "!= NULL" on purpose, since it is more 
emphasized than the checkpatch.pl suggested way, and I tend to use the nullptr explicitly.

BTW, It seems other filesystems still use "== NULL" or "!= NULL" explicitly, too, eg:
xfs, ext4, ext2, ocfs2, etc... You could 'grep' in the fs directory... 

Other commits look good for me at glance.

Thanks,
Gao Xiang

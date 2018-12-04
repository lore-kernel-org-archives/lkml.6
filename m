Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18265C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2BD20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+oB3dRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2BD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLDMGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:06:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37781 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:06:53 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so14004579iti.2;
        Tue, 04 Dec 2018 04:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbGGxqVG/mnq0yhffwYo9a4DBJQEfAh0oF02xMjRwqA=;
        b=t+oB3dRPtQ8uMm7R9Jd7LsmA44JLq8Df3Ja3ai5hTljVx2Kl3HomZeJMkOsi7yr02q
         4JqADnHgze7oSO25oS/bGwt2+WNOcLwZAeNXoH98D0fDjRMNiXn+P/kTyZ8rN/jPyp1X
         4QlVXEDXqmfDJUf5AwHEjxO9MwH+Crlu60KO1HH82zfDnu3bRHUGK7nJegP8wR0vwvRk
         jQsB9HUYY+uHxkJeaAgn/znQtsAnFcPeKUQsqNezcJVqxtUCoRuBV6q66QuLOO7YkKgq
         HdCwNv4S2PRji/grzPZuuMO38dRIKmyck4gPMPnbka6VZNXbCw6jwf7QTT79Y5OUYk9d
         Kk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbGGxqVG/mnq0yhffwYo9a4DBJQEfAh0oF02xMjRwqA=;
        b=BHRuCTLiSZB6jVmVRh6UeYgonG6iJ/lLEzTZ0aO9m58lcJ5NIyQ/GwgI2ysGoU2XXW
         oIFl6zzk9PGZ88O/jS1E4WjPRZKUZDLZYWNXJ8VMIGbV3IYRN70zguqZQKLBHUpqHeI2
         NxMeO6NncdXAsVpd0T/fP4IP94xsj8YJ2uPrjy/FrB3j2iQxEKEp57yB4VNoBOnmEo+d
         8AhlQdzmkaUrQq6gflalvocGWuZmzncXs91mo0ywU9CBAvaOQqgKE2kkUlJLAEuFlyUZ
         Ec/5ziAYb/42yOIDuoLrpMvI26k3LvyGvy3VelOwymX+lxcVMDNKYCvyg3D7E4yWkWgC
         0N5w==
X-Gm-Message-State: AA+aEWZXgtw3AAEsOXP4STl/1LJKTkveYbcfvT+OP2xu8+iGCRGOpopS
        4VGGzDBJde2/tmQCVBx8lmTRTSP6bmDQEGOmNLCPHMPg
X-Google-Smtp-Source: AFSGD/Wuqc1VKF7cwUIp1UU1mGn7OI76/FlcX0MlZhuCKfkuqmBlkdbVrG6piFYJ4084OveGNoFJYOtp5A66Ozt0Jss=
X-Received: by 2002:a24:cfc1:: with SMTP id y184mr10414603itf.72.1543925211580;
 Tue, 04 Dec 2018 04:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20181204103726.750894136@linuxfoundation.org> <20181204103727.530335739@linuxfoundation.org>
In-Reply-To: <20181204103727.530335739@linuxfoundation.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 4 Dec 2018 13:06:40 +0100
Message-ID: <CAOi1vP_uNBXySo4yNOjcSBUgqDRjo2abm41UZCXazUG7ygRVcA@mail.gmail.com>
Subject: Re: [PATCH 4.14 018/146] libceph: implement CEPHX_V2 calculation mode
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sage Weil <sage@redhat.com>, ben.hutchings@codethink.co.uk,
        sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 12:01 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> commit cc255c76c70f7a87d97939621eae04b600d9f4a1 upstream.
>
> Derive the signature from the entire buffer (both AES cipher blocks)
> instead of using just the first half of the first block, leaving out
> data_crc entirely.
>
> This addresses CVE-2018-1129.
>
> Link: http://tracker.ceph.com/issues/24837
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Reviewed-by: Sage Weil <sage@redhat.com>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/ceph/ceph_features.h |  7 +--
>  net/ceph/auth_x.c                  | 73 +++++++++++++++++++++++-------
>  2 files changed, 60 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> index 59042d5ac520..70f42eef813b 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -165,9 +165,9 @@ DEFINE_CEPH_FEATURE(58, 1, FS_FILE_LAYOUT_V2) // overlap
>  DEFINE_CEPH_FEATURE(59, 1, FS_BTIME)
>  DEFINE_CEPH_FEATURE(59, 1, FS_CHANGE_ATTR) // overlap
>  DEFINE_CEPH_FEATURE(59, 1, MSG_ADDR2) // overlap
> -DEFINE_CEPH_FEATURE(60, 1, BLKIN_TRACING)  // *do not share this bit*
> +DEFINE_CEPH_FEATURE(60, 1, OSD_RECOVERY_DELETES) // *do not share this bit*
> +DEFINE_CEPH_FEATURE(61, 1, CEPHX_V2)             // *do not share this bit*
>
> -DEFINE_CEPH_FEATURE(61, 1, RESERVED2)          // unused, but slow down!
>  DEFINE_CEPH_FEATURE(62, 1, RESERVED)           // do not use; used as a sentinal
>  DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facing
>
> @@ -209,7 +209,8 @@ DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facin
>          CEPH_FEATURE_SERVER_JEWEL |            \
>          CEPH_FEATURE_MON_STATEFUL_SUB |        \
>          CEPH_FEATURE_CRUSH_TUNABLES5 |         \
> -        CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING)
> +        CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING | \
> +        CEPH_FEATURE_CEPHX_V2)
>
>  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
>         (CEPH_FEATURE_NOSRCADDR |        \
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index ce28bb07d8fd..10eb759bbcb4 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/ceph/decode.h>
>  #include <linux/ceph/auth.h>
> +#include <linux/ceph/ceph_features.h>
>  #include <linux/ceph/libceph.h>
>  #include <linux/ceph/messenger.h>
>
> @@ -803,26 +804,64 @@ static int calc_signature(struct ceph_x_authorizer *au, struct ceph_msg *msg,
>                           __le64 *psig)
>  {
>         void *enc_buf = au->enc_buf;
> -       struct {
> -               __le32 len;
> -               __le32 header_crc;
> -               __le32 front_crc;
> -               __le32 middle_crc;
> -               __le32 data_crc;
> -       } __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
>         int ret;
>
> -       sigblock->len = cpu_to_le32(4*sizeof(u32));
> -       sigblock->header_crc = msg->hdr.crc;
> -       sigblock->front_crc = msg->footer.front_crc;
> -       sigblock->middle_crc = msg->footer.middle_crc;
> -       sigblock->data_crc =  msg->footer.data_crc;
> -       ret = ceph_x_encrypt(&au->session_key, enc_buf, CEPHX_AU_ENC_BUF_LEN,
> -                            sizeof(*sigblock));
> -       if (ret < 0)
> -               return ret;
> +       if (!CEPH_HAVE_FEATURE(msg->con->peer_features, CEPHX_V2)) {
> +               struct {
> +                       __le32 len;
> +                       __le32 header_crc;
> +                       __le32 front_crc;
> +                       __le32 middle_crc;
> +                       __le32 data_crc;
> +               } __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
> +
> +               sigblock->len = cpu_to_le32(4*sizeof(u32));
> +               sigblock->header_crc = msg->hdr.crc;
> +               sigblock->front_crc = msg->footer.front_crc;
> +               sigblock->middle_crc = msg->footer.middle_crc;
> +               sigblock->data_crc =  msg->footer.data_crc;
> +
> +               ret = ceph_x_encrypt(&au->session_key, enc_buf,
> +                                    CEPHX_AU_ENC_BUF_LEN, sizeof(*sigblock));
> +               if (ret < 0)
> +                       return ret;
> +
> +               *psig = *(__le64 *)(enc_buf + sizeof(u32));
> +       } else {
> +               struct {
> +                       __le32 header_crc;
> +                       __le32 front_crc;
> +                       __le32 front_len;
> +                       __le32 middle_crc;
> +                       __le32 middle_len;
> +                       __le32 data_crc;
> +                       __le32 data_len;
> +                       __le32 seq_lower_word;
> +               } __packed *sigblock = enc_buf;
> +               struct {
> +                       __le64 a, b, c, d;
> +               } __packed *penc = enc_buf;
> +               int ciphertext_len;
> +
> +               sigblock->header_crc = msg->hdr.crc;
> +               sigblock->front_crc = msg->footer.front_crc;
> +               sigblock->front_len = msg->hdr.front_len;
> +               sigblock->middle_crc = msg->footer.middle_crc;
> +               sigblock->middle_len = msg->hdr.middle_len;
> +               sigblock->data_crc =  msg->footer.data_crc;
> +               sigblock->data_len = msg->hdr.data_len;
> +               sigblock->seq_lower_word = *(__le32 *)&msg->hdr.seq;
> +
> +               /* no leading len, no ceph_x_encrypt_header */
> +               ret = ceph_crypt(&au->session_key, true, enc_buf,
> +                                CEPHX_AU_ENC_BUF_LEN, sizeof(*sigblock),
> +                                &ciphertext_len);
> +               if (ret)
> +                       return ret;
> +
> +               *psig = penc->a ^ penc->b ^ penc->c ^ penc->d;
> +       }
>
> -       *psig = *(__le64 *)(enc_buf + sizeof(u32));
>         return 0;
>  }

Hi Greg,

I thought this series (patches 13 - 18) was dropped from the 4.14 queue.
If it wasn't, you also need to pick up the following:

f1d10e046379 libceph: weaken sizeof check in ceph_x_verify_authorizer_reply()
130f52f2b203 libceph: check authorizer reply/challenge length before reading

See our discussion with Sasha:

  https://www.spinics.net/lists/stable/msg272462.html

Thanks,

                Ilya

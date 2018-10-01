Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AEEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1382821473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBe+/JfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1382821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJBFaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:30:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33270 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBFaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:30:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so22150pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPPhxjF+V8j6BylsFjnvtWVfyZPMgxgbzA0jeqxnhv4=;
        b=oBe+/JfISBHkxJt7P8IR+EWjRNTixujPpxmIsgHINCJZBUrJC5Cv2blxIyTng93nJz
         jE4iaBdI4Ygi9JMrF8IOFdFnDIAVzB+i1IutnpwW50ZQeVu4ca3WddaBqmZVIzdTmimp
         FF+S7nI+1aSnA8tff8Iy7YaY7sBwpCMY1HzkLbvnYjWAEr7IjJW8m4GLBkIgvKE4UYHi
         QGvS7Pvhwg26EuppZkiuiJRZXL/fivob0HeTxwSWarcyQ9dT0mor/3Pyfg3I5Flt9vZf
         ryuA+FxLZRutyBz1xkl8No/zmO0opvQXXrTgoEL6h0bsWg2Z+4cGOMkKtBH9B6kOcHFi
         9ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPPhxjF+V8j6BylsFjnvtWVfyZPMgxgbzA0jeqxnhv4=;
        b=ifanx4GqSNuPLu6DsWlDOGRDWL7r/K2E1PqC9iquMyxnVTQSJE3JfnPOOy1C4R45oq
         kfoINZGM5S74ZrFQbBkUO6zowNJGUQf4dyFUub+lknlsZW+MTeKQvzLCMqLELUCXYiTY
         XpeGK4u3tKkRJaL0j09oXD3zKZcp9oGRkrPXqTHXM6ahyN4zxKzEEZGmF97ubu20xuRQ
         j4KLqVubNyGLEJupUn+mv/UDdKH2yAdZDargCnnTuW4nzN3pz0hY2yuXER38WIJQUxo0
         jxCTK0efsmkPAx5iFjz8xvKgg0msrkBDwBmMasWp4v5UqONY6zYjl0Q2gJbbz9qxw1qT
         UfdA==
X-Gm-Message-State: ABuFfogS225y7h7BzkiSjVCqz+QR3IuIJVrHsav5eSghXm5UTzktOVzc
        k0r0I3Re5GdBRbgY7B0v9hDEhrXwJrpUh3n/guVMpQ==
X-Google-Smtp-Source: ACcGV63j7MwE0B/6qkcCXYTJq8LoxOYBZN2KOlqiv40qPzJeYJ02Icx9J7rnc/wl6qiCFAW8qddNrxo0AzYcnESyBq0=
X-Received: by 2002:a17:902:82c9:: with SMTP id u9-v6mr7681908plz.320.1538434213765;
 Mon, 01 Oct 2018 15:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181001034738.29475-1-natechancellor@gmail.com>
In-Reply-To: <20181001034738.29475-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 15:50:02 -0700
Message-ID: <CAKwvOd=jSsfJmGsn4bqTSFLKnYwHUWMdOvkhoUsGbT3vG385mA@mail.gmail.com>
Subject: Re: [PATCH] cxgb4: Use proper enum in IEEE_FAUX_SYNC
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     ganeshgr@chelsio.com, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 8:47 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:390:4: warning: implicit
> conversion from enumeration type 'enum cxgb4_dcb_state' to different
> enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]

Luckily these 2 enums had the same values, so this change is no
functional change.  Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                         IEEE_FAUX_SYNC(dev, dcb);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h:70:10: note: expanded
> from macro 'IEEE_FAUX_SYNC'
>                                             CXGB4_DCB_STATE_FW_ALLSYNCED);
>                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Use the equivalent value of the expected type to silence Clang while
> resulting in no functional change.
>
> CXGB4_DCB_STATE_FW_ALLSYNCED = CXGB4_DCB_INPUT_FW_ALLSYNCED = 3
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
> index 02040b99c78a..484ee8290090 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h
> @@ -67,7 +67,7 @@
>         do { \
>                 if ((__dcb)->dcb_version == FW_PORT_DCB_VER_IEEE) \
>                         cxgb4_dcb_state_fsm((__dev), \
> -                                           CXGB4_DCB_STATE_FW_ALLSYNCED); \
> +                                           CXGB4_DCB_INPUT_FW_ALLSYNCED); \
>         } while (0)
>
>  /* States we can be in for a port's Data Center Bridging.
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers

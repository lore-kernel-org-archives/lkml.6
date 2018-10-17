Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638BAECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0170D2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/t6E543"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0170D2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJRAOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:14:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39399 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeJRAOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:14:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id l58so26767614otd.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=baZoJGHlt/JRVlcWkXsycTPAGYeJ3sejv9lPgzYWEIM=;
        b=U/t6E5430HrmjWxwYPig/5ISgYETl766LGeOC76gqOLARHXHoBrFHHOGG2hZDxho1h
         26bwhtEPaa2r6bKFXzC6U2v+rhgOijYScXl2gqgQaVhSpnoi5mZW1bkxNluPNQb0o5fW
         /WTjAkSKuumC/UC1H0dmTlRd09TZySrTTuAW4rmBmTDs9FTvj+CzYQylmISHd00/eqBF
         Ang2RTvCGGDkPSLdAd2KduCYnL9x4vds9fuh7VO5rvhS3YA5HsYeWHVEgYkX2SINtLXm
         nEewj6TXkjZt9Tdqq22z46NF2+9GaxNQ9NhqNGexAh2rSZ4MDsrAaCufRZwQzIY3is+4
         hoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baZoJGHlt/JRVlcWkXsycTPAGYeJ3sejv9lPgzYWEIM=;
        b=EGdhLDHHCX6MmXO/KvfU34A9Vk50J0BdTD98wikpHuAK1dYhFG5KWEGshsoxPbrJBc
         4XV+2PpiHHrpl2anktLMJYWILFd+cAneu7YGKjIeRc6+SVE87tvqKbHRnXd4KesdySJo
         ghLanNd7fTIoy9f9GBjnPE7RmvevKwK6iSjPNT434enNRfyArRFW7IwNDcXcBH1pgvgH
         QVnlFDp3apQzvZMN8ll9gSb7JmCSfnGwv521l8U2Uz1Z4xEEy7dOPY0u7QqaDXdcstFi
         V0eXN0bU6lXtpJPeYggG2pdcknV+dgvgi9vksU4uhtLD4fsD5UFdt2uQGCbf52neMHC+
         bkGQ==
X-Gm-Message-State: ABuFfoiXgqQzVthGVyEf7ndoUlVYUU5jjpVjtfF1sG+zfsXHTm4mYj5i
        AmgIIowjaKit0SuKLbsGDGAFSxNC5D0rYQl2XuvBWw==
X-Google-Smtp-Source: ACcGV62FA9UQ/YSMtP+TDByATqeqQeg6614JjAkZF/pM3pwQnUGenZq8LyhzqPYeLELsq6wlzrw1DRD3RVbMJWu1UQc=
X-Received: by 2002:a9d:429a:: with SMTP id r26mr17794489ote.337.1539793061494;
 Wed, 17 Oct 2018 09:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180907133837.66047-1-maco@android.com>
In-Reply-To: <20180907133837.66047-1-maco@android.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 17 Oct 2018 09:17:30 -0700
Message-ID: <CAHRSSEx1vAMWBH3t0uS3CcrBi+zkVmcU0o_+QWP+vW_=+73anA@mail.gmail.com>
Subject: Re: [PATCH v2] ANDROID: binder: Add BINDER_GET_NODE_INFO_FOR_REF ioctl.
To:     Martijn Coenen <maco@android.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Steven Moreland <smoreland@google.com>,
        Peter Kalauskas <peskal@google.com>,
        Robert Benea <robenea@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 6:38 AM Martijn Coenen <maco@android.com> wrote:
>
> This allows the context manager to retrieve information about nodes
> that it holds a reference to, such as the current number of
> references to those nodes.
>
> Such information can for example be used to determine whether the
> servicemanager is the only process holding a reference to a node.
> This information can then be passed on to the process holding the
> node, which can in turn decide whether it wants to shut down to
> reduce resource usage.
>
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
> v2: made sure reserved fields are aligned, and enforce caller zeroes
>     all fields except handle, as suggested by Dan Carpenter.
>
>  drivers/android/binder.c            | 55 +++++++++++++++++++++++++++++
>  include/uapi/linux/android/binder.h | 10 ++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d58763b6b0090..5b25412e15ccf 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4544,6 +4544,42 @@ static int binder_ioctl_set_ctx_mgr(struct file *filp)
>         return ret;
>  }
>
> +static int binder_ioctl_get_node_info_for_ref(struct binder_proc *proc,
> +               struct binder_node_info_for_ref *info)
> +{
> +       struct binder_node *node;
> +       struct binder_context *context = proc->context;
> +       __u32 handle = info->handle;
> +
> +       if (info->strong_count || info->weak_count || info->reserved1 ||
> +           info->reserved2 || info->reserved3) {
> +               binder_user_error("%d BINDER_GET_NODE_INFO_FOR_REF: only handle may be non-zero.",
> +                                 proc->pid);
> +               return -EINVAL;
> +       }
> +
> +       /* This ioctl may only be used by the context manager */
> +       mutex_lock(&context->context_mgr_node_lock);
> +       if (!context->binder_context_mgr_node ||
> +               context->binder_context_mgr_node->proc != proc) {
> +               mutex_unlock(&context->context_mgr_node_lock);
> +               return -EPERM;
> +       }
> +       mutex_unlock(&context->context_mgr_node_lock);
> +
> +       node = binder_get_node_from_ref(proc, handle, true, NULL);
> +       if (!node)
> +               return -EINVAL;
> +
> +       info->strong_count = node->local_strong_refs +
> +               node->internal_strong_refs;
> +       info->weak_count = node->local_weak_refs;

Aren't we under-reporting the weak refs here? The "internal weak" refs
are the count of elements in node->refs, so we need to add something
like:

hlist_for_each_entry(ref, &node->refs, node_entry)
        info->weak_count++;

> +
> +       binder_put_node(node);
> +
> +       return 0;
> +}
> +
>  static int binder_ioctl_get_node_debug_info(struct binder_proc *proc,
>                                 struct binder_node_debug_info *info)
>  {
> @@ -4638,6 +4674,25 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 }
>                 break;
>         }
> +       case BINDER_GET_NODE_INFO_FOR_REF: {
> +               struct binder_node_info_for_ref info;
> +
> +               if (copy_from_user(&info, ubuf, sizeof(info))) {
> +                       ret = -EFAULT;
> +                       goto err;
> +               }
> +
> +               ret = binder_ioctl_get_node_info_for_ref(proc, &info);
> +               if (ret < 0)
> +                       goto err;
> +
> +               if (copy_to_user(ubuf, &info, sizeof(info))) {
> +                       ret = -EFAULT;
> +                       goto err;
> +               }
> +
> +               break;
> +       }
>         case BINDER_GET_NODE_DEBUG_INFO: {
>                 struct binder_node_debug_info info;
>
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index bfaec6903b8bc..b9ba520f7e4bb 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -200,6 +200,15 @@ struct binder_node_debug_info {
>         __u32            has_weak_ref;
>  };
>
> +struct binder_node_info_for_ref {
> +       __u32            handle;
> +       __u32            strong_count;
> +       __u32            weak_count;
> +       __u32            reserved1;
> +       __u32            reserved2;
> +       __u32            reserved3;
> +};
> +
>  #define BINDER_WRITE_READ              _IOWR('b', 1, struct binder_write_read)
>  #define BINDER_SET_IDLE_TIMEOUT                _IOW('b', 3, __s64)
>  #define BINDER_SET_MAX_THREADS         _IOW('b', 5, __u32)
> @@ -208,6 +217,7 @@ struct binder_node_debug_info {
>  #define BINDER_THREAD_EXIT             _IOW('b', 8, __s32)
>  #define BINDER_VERSION                 _IOWR('b', 9, struct binder_version)
>  #define BINDER_GET_NODE_DEBUG_INFO     _IOWR('b', 11, struct binder_node_debug_info)
> +#define BINDER_GET_NODE_INFO_FOR_REF   _IOWR('b', 12, struct binder_node_info_for_ref)
>
>  /*
>   * NOTE: Two special error codes you should check for when calling
> --
> 2.19.0.rc2.392.g5ba43deb5a-goog
>

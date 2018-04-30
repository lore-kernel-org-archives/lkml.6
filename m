Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755417AbeD3Wkd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 18:40:33 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:45268 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755379AbeD3Wkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 18:40:31 -0400
X-Google-Smtp-Source: AB8JxZqeR8vcmkS0F3kFvInIm89+VXaPOXZoPilfZksI+NVGTncA180EKX7Q3Ye2XrwWaj5L2aZVtU1kITSA2MJTXPU=
MIME-Version: 1.0
In-Reply-To: <1524862838-8247-4-git-send-email-longman@redhat.com>
References: <1524862838-8247-1-git-send-email-longman@redhat.com> <1524862838-8247-4-git-send-email-longman@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Apr 2018 15:40:29 -0700
X-Google-Sender-Auth: JxC2T18zJeqKAf-C0vlStqhW5ow
Message-ID: <CAGXu5jJrkeJTCrajYh3oCnYsfLCtL+LBvRbMn75p4=gxKzBpcQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] sysctl: Warn when a clamped sysctl parameter is
 set out of range
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I like this series overall, thanks! No objections from me. One thing I
noted, though:

On Fri, Apr 27, 2018 at 2:00 PM, Waiman Long <longman@redhat.com> wrote:
>                 if (param->min && *param->min > val) {
>                         if (clamp) {
>                                 val = *param->min;
> +                               clamped = true;
>                         } else {
>                                 return -EINVAL;
>                         }

This appears as a common bit of logic in many places in the series. It
seems like it'd make sense to make this a helper of some kind?

-Kees

-- 
Kees Cook
Pixel Security

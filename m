Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbeBGR52 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:57:28 -0500
Received: from sonic304-17.consmr.mail.bf2.yahoo.com ([74.6.128.40]:40438 "EHLO
        sonic304-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753896AbeBGR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:57:27 -0500
X-YMail-OSG: yTaeiDMVM1mWQhp8n9X2QpSnlDlcrDMLS9rQbCEybbi3P57whYKDvX8iEeLUsiT
 6lmLWu3tXI6Ak5h9jBYbmrk_iSxi21Q87aMADyNrG_rK2IUzgXiB4NH5X0EMgIYn6_L.bW2PNVOB
 cWRi2SqP4Qic0DIoUk6hL6MPDg7r3NZgSQjimRo7H3HfDw_s3hZVy3hCwxUFb10PLewA1rmYIt.E
 QhZKh7gQRT_p2AINWkWqngJiQ6oglwsqqLsuLN6DAQTvYok_l_W7.IfFDG3THgnX8cG.QkEu0JiP
 22UbUY8hBSzJi.7srzpXGZ9bobQR6sCj_UNBpmg0ykHvaYBRc9xTKi3eaZDkoWXWaqH4yzrUrxj.
 6Mbxhf0RG6_UZ9.k5YN60KfV248tRDGnkygoQUA9vaHpti19fDYeDYBL73F.DleFLcOT8MvsyoHA
 lff0ddd_DlbSbai.P5hG2GazCqIo9UWi.cZ2WbMBo7GWKgYjnyJ.WCB8i1H4V02s9PoSt9baH4gb
 .mvI9lUHJ7oq5PsW.nGn9lamDa1FbashD0DstmX4u3QM8yhs-
Subject: Re: adding plan9-like usernames to the kernel
To: "Enrico Weigelt, metux IT consult" <metux@gmx.de>,
        linux-kernel@vger.kernel.org
Cc: aganti@google.com
References: <0597ffe1-f80e-d5dd-e20d-da68bd8a189a@gmx.de>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <35e47ff4-7f61-c72d-f09f-a656dc8480df@schaufler-ca.com>
Date: Wed, 7 Feb 2018 09:57:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0597ffe1-f80e-d5dd-e20d-da68bd8a189a@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/2018 4:38 AM, Enrico Weigelt, metux IT consult wrote:
> Hi folks,
>
>
> as part as a little research project for bringing Plan9 semantics
> to Linux, I'd like to add textual usernames. In contrast to *nix,
> Plan9 doesn't use numerical IDs, but names.
>
> Obviously that needs some internal mapping between names and ids.
>
> Should this go into struct user_namespace (where per-namespace
> uid mapping lives) or to struct cred / struct user_struct ?

Why not keep a mapping associated with your devices?

>
> The primary consumer of this username will be the /dev/caphash
> and /dev/capuse devices for switching the UID.
> (an interesting question of course is, how to allocate the
> numerical UIDs for given usernames)

You read it from /etc/passwd (or the equivalent service)
and write it to your device based list via an ioctl, or a
companion device (/dev/capset?). If no one outside your
devices is using it this would be the logical place for
the data to reside.

>
>
> --mtx
>

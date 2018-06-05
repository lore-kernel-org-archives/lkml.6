Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeFEW0h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:26:37 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36297 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeFEW0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:26:34 -0400
X-Google-Smtp-Source: ADUXVKLKfBNe97cYg/JukgiklWlSEBJBcjb5LB/lJ1aMxUIRcL+8byWBVkTdLZuFrqBLcfQqrPhKYHu+dv51c4aNWYk=
MIME-Version: 1.0
In-Reply-To: <1528234513.3557.16.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
 <1527635645.3534.39.camel@linux.vnet.ibm.com> <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
 <1527780226.3427.20.camel@linux.vnet.ibm.com> <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
 <1528234513.3557.16.camel@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 15:26:32 -0700
X-Google-Sender-Auth: bH_kFP1edTq5mO_-r2mxzjCAya4
Message-ID: <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in init_module
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 2:35 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-06-05 at 12:45 -0700, Kees Cook wrote:
>
>> And if you must have a separate enum, please change this to fail
>> closed instead of open (and mark the fall-through):
>>
>> int rc = -EPERM;
>>
>> switch (id) {
>> case LOADING_MODULE:
>>     rc = loadpin_read_file(NULL, READING_MODULE);
>>     /* Fall-through */
>> default:
>>     break;
>> }
>
> This will fail the sysfs firmware fallback loading and the kexec_load
> syscall without any message, as you have for init_module.  Is that
> what you want?

I'd prefer there be a full mapping of the enums so that everything
gets passed into loadpin_read_file() :)

Can the enum be shared or is that nonsensical?

-Kees

-- 
Kees Cook
Pixel Security

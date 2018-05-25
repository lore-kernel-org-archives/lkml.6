Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966661AbeEYPoU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:44:20 -0400
Received: from namei.org ([65.99.196.166]:37118 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965729AbeEYPoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:44:18 -0400
Date: Sat, 26 May 2018 01:41:52 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file()
 hook
In-Reply-To: <87po1k2304.fsf@xmission.com>
Message-ID: <alpine.LRH.2.21.1805260139030.11624@namei.org>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>        <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com> <87po1k2304.fsf@xmission.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, Eric W. Biederman wrote:

> Below is where I suggest you start on sorting out these security hooks.
> - Adding a security_kernel_arg to catch when you want to allow/deny the
>   use of an argument to a syscall.  What security_kernel_file_read and
>   security_kernel_file_post_read have been abused for.

NAK. This abstraction is too semantically weak.

LSM hooks need to map to stronger semantics so we can reason about what 
the hook and the policy is supposed to be mediating.

-- 
James Morris
<jmorris@namei.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755112AbeCSEwb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 00:52:31 -0400
Received: from namei.org ([65.99.196.166]:53460 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeCSEwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 00:52:30 -0400
Date: Mon, 19 Mar 2018 15:52:18 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Kees Cook <keescook@chromium.org>
cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2] exec: Set file unwritable before LSM check
In-Reply-To: <20180309193020.GA5149@beast>
Message-ID: <alpine.LRH.2.21.1803191551580.5791@namei.org>
References: <20180309193020.GA5149@beast>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, Kees Cook wrote:

> The LSM check should happen after the file has been confirmed to be
> unchanging. Without this, we could have a race between the Time of Check
> (the call to security_kernel_read_file() which could read the file and
> make access policy decisions) and the Time of Use (starting with
> kernel_read_file()'s reading of the file contents). In theory, file
> contents could change between the two.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: Clarify the ToC/ToU race (Linus)

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing


-- 
James Morris
<jmorris@namei.org>

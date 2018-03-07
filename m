Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933879AbeCGP2m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:28:42 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49418 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933335AbeCGP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:28:39 -0500
Message-ID: <1520436517.5558.2.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/9] KEYS: Blacklisting & UEFI database load
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, Jiri Slaby <jslaby@suse.cz>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc: matthew.garrett@nebula.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Mar 2018 07:28:37 -0800
In-Reply-To: <1520428682.10396.445.camel@linux.vnet.ibm.com>
References: <147931984418.16460.6639993676886095760.stgit@warthog.procyon.org.uk>
         <6eabbb43-295e-9ba0-c0d9-120f48aa0e1d@suse.cz>
         <1520428682.10396.445.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 08:18 -0500, Mimi Zohar wrote:
> On Tue, 2018-03-06 at 15:05 +0100, Jiri Slaby wrote:
> > what's the status of this please? Distributors (I checked SUSE,
> > RedHat and Ubuntu) have to carry these patches and every of them
> > have to forward-port the patches to new kernels. So are you going
> > to resend the PR to have this merged?
[...]
> Just because I trust the platform keys prior to booting the kernel,
> doesn't mean that I *want* to trust those keys once booted.  There
> are, however, places where we need access to those keys to verify a
> signature (eg. kexec kernel image).

Which is essentially the reason I always give when these patches come
back

> Nayna Jain's "certs: define a trusted platform keyring" patch set
> introduces a new, separate keyring for these platform keys.

Perhaps, to break the deadlock, we should ask Jiří what the reason is
the distros want these keys to be trusted.  Apart from the Microsoft
key, it will also give you an OEM key in your trusted keyring.  Is it
something to do with OEM supplied modules?

James

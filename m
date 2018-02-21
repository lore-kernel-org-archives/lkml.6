Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBUUSn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:18:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57960 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeBUUSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:18:42 -0500
Date: Wed, 21 Feb 2018 20:18:40 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: SVM: Fix sparse: incorrect type in argument 1
 (different base types)
Message-ID: <20180221201839.GK30522@ZenIV.linux.org.uk>
References: <20180219161228.46931-1-brijesh.singh@amd.com>
 <20180221174910.GI30522@ZenIV.linux.org.uk>
 <f55f25f6-559d-bb93-5605-af66678438c2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f55f25f6-559d-bb93-5605-af66678438c2@amd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 01:59:55PM -0600, Brijesh Singh wrote:

> Sure, checking access_ok() does not guarantee that later
> copy_from_user() will not fail. But it does eliminate one possible
> reason for the failure. We are trying to validate most of the user
> inputs before we invoke  SEV command.

That makes no sense whatsoever.  If user is deliberately fuzzing
your code or trying to DoS it, that "validation" doesn't buy you
anything - they can just as well feed you NULL, after all.

What is the rationale for that?  "Userland is accidentally feeding
us garbage pointers" is the case where slowness is the least of your
concerns...

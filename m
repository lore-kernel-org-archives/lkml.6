Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeCPSFu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:05:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38279 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbeCPSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:05:49 -0400
X-Google-Smtp-Source: AG47ELv2KqOjtR6WtcJsLl7EpSWpCqu0C8QqOnDLvVc6e+6d1O4NP3y11B/f61qVtQShde+XU0zjcg==
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.17.0-rc0
References: <xmqqwoyc3kir.fsf@gitster-ct.c.googlers.com>
        <87fu50e0ht.fsf@evledraar.gmail.com>
Date: Fri, 16 Mar 2018 11:05:45 -0700
In-Reply-To: <87fu50e0ht.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 16 Mar 2018 12:14:06 +0100")
Message-ID: <xmqqbmfn3ngm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Mar 16 2018, Junio C. Hamano jotted:
>
>>       gitweb: hard-depend on the Digest::MD5 5.8 module
>
> I've just noticed this now, but while this module is in 5.8 RedHat's
> butchered perl doesn't have it in the base system, thus this introduces
> the do-we-even-care regression that git's full test suite won't pass on
> a RedHat (or CentOS) base system, because the gitweb tests will fail to
> "use" Digest::MD5.
>
> I'm slightly leaning towards not caring about it, since there's no other
> perl distributor that does this sort of split-out of the core, and if
> you're on a RedHat system they're solving your package problems, so this
> really only impacts the edge case of git developers and redhat
> packagers, both of whom can just do "yum install -y perl-Digest-MD5" to
> fix it.

Thanks for noting.  I agree that this is not something that requires
more than a mention near the beginning of release notes.

I haven't wordsmithed it fully, but it should say something along
the lines of ...

 Documentation/RelNotes/2.16.0.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/RelNotes/2.16.0.txt b/Documentation/RelNotes/2.16.0.txt
index 8f0461eefd..8b4c24200b 100644
--- a/Documentation/RelNotes/2.16.0.txt
+++ b/Documentation/RelNotes/2.16.0.txt
@@ -6,6 +6,16 @@ Backward compatibility notes and other notable changes.
  * Use of an empty string as a pathspec element that is used for
    'everything matches' is now an error.
 
+ * Part of Git that depends on Perl have required at least Perl 5.8
+   since Git v1.7.4 released in 2010, but we used to assume some core
+   modules from Perl distribution may not exist on the system and did
+   a conditional "eval { require <<module>> }"; we no longer do this.
+   On a platform that ships a stripped-down Perl by default, the user
+   may have to install modules the platform chooses not to ship as
+   part of its core (e.g. Digest::MD5, File::Temp, File::Spec,
+   Net::SMTP, NET::Domain).  RedHat/CentOS excludes Digest::MD5 from
+   its base installation, for example.
+
 
 Updates since v2.15
 -------------------

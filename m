Return-Path: <paul@paul-moore.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520362863; cv=none;
        d=google.com; s=arc-20160816;
        b=qvmgSpEjFOkEF2cOb9LZiC2hiHwMOHh2hsGG1kA1BKe8Rb15IwHto4EGM05H59TbhV
         UYH74V+5BWqetqJbQ1ob/swDQ1VsB1UjHeKD6vWTdD8C4XkVyu2xbVZ6pMv3Eung6WCj
         zl4diKd+arPv0YCKxT7G5039lbKWR1p6Ah7xlzM77SgKouP4VD/4oPQ1UjtlVbgQLlwr
         1wmni3s/Uc8E7bvSz0GrADR5+nE7ev2bCMwpAzwczIWyCPkX8h76mROFozvIodzrcck0
         FtsKG4ArSm4BehkhUggjL/vz+LjORbR2viTJEPQWbyfmgmiMAFNCwFWIWazhxxWt4aWX
         ixTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mwPTgvt4aKm90UJRjt3yGYVQFp/Cv0hLmHdwlpryTBo=;
        b=H1dqFzbxauYnOZisvIxDjK9GRs0A4i1dePQ4Ns/Ay9nXglw18Zcr8fqRX7c6qiQq52
         PXVNq9rpTAjwfhYFop/OWhaHuqwvx0zXsQ8hgHIplZzCcFY9bGdlaY7ZqRVoW/Bti+26
         mMdWAEz6zRL/uEgCtCxmmFGQNdp7C8/xYwMverb5hQTD3MlKwvLSfuMK8j57Jk9w/K6e
         EXLx7qfoFoC6ebhNB7MJ4Z9UH3ALEwX8sE11YvbLYSxDYO1Ny/xdn17iboKeR4t8wMBK
         1ybjsZMBBnI2ihoO7w+zOpwrPT6GnR043WBL2Tv8y3BFaudmoL5SuLn86WdA7u78cy2j
         VZPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@paul-moore-com.20150623.gappssmtp.com header.s=20150623 header.b=y3RihPtR;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of paul@paul-moore.com) smtp.mailfrom=paul@paul-moore.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@paul-moore-com.20150623.gappssmtp.com header.s=20150623 header.b=y3RihPtR;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of paul@paul-moore.com) smtp.mailfrom=paul@paul-moore.com
X-Google-Smtp-Source: AG47ELtmn75FqByf610glgFkE+vUme11EJB1gG2wus2tKoMW1Krpm2ECDcb6Ro09oX67dbEdrZaWuNG7madXBnoO2xo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <alpine.LRH.2.21.1709090808200.15026@namei.org>
References: <20170908164001.21138-1-sds@tycho.nsa.gov> <CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
 <alpine.LRH.2.21.1709090808200.15026@namei.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Mar 2018 14:01:01 -0500
Message-ID: <CAHC9VhQ3YRmk7k5DQO9zoGKRXi3CSTHvmRuLa891NVWsVNCZZA@mail.gmail.com>
Subject: Re: [PATCH] usb,signal,security: only pass the cred, not the secid,
 to kill_pid_info_as_cred and security_task_kill
To: James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
	John Johansen <john.johansen@canonical.com>, James Morris <james.l.morris@oracle.com>,
	gregkh@linuxfoundation.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1577990101774039350?=
X-GMAIL-MSGID: =?utf-8?q?1594216009833366613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Sep 8, 2017 at 6:09 PM, James Morris <jmorris@namei.org> wrote:
> On Fri, 8 Sep 2017, Paul Moore wrote:
>> Looks fine to me from a SELinux perspective.  If Casey and John are
>> happy with this I can volunteer to pull it into the selinux/next tree
>> (once the merge window closes), otherwise if someone else wants to
>> merge this my ack is below.
>
> As this impacts multiple LSMs, I'd prefer to take it via my tree.

What happened to this James?  As best I can tell there were never any
objections, and plenty of ACKs, but I don't see it in Linus' tree.
I'll extend my offer to merge it, but I know you expressed a desire to
pull this via your tree.

* http://kernsec.org/pipermail/linux-security-module-archive/2017-September/003156.html

-- 
paul moore
www.paul-moore.com

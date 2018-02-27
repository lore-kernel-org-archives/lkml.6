Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-40595-1519694618-2-10841779422927891928
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519694618; b=eaqoxlRQ8kcFI2Gvzft4sjJcqMHUV2bbAUBrMt4JBz2qerh
    iAIa+U+dneSAHqpRDpiBMfNI0+uVfMf+g5FlC5WfPygQfM/LUkho5SXFqVNdPNNn
    EVLAotDnT3vZmMYj4RFXIuWpcG+ikQFFxxKnnEiCgSBwhjPW3mQhIZa7keN+L0Oy
    vuS4chLiAIb9zItjk+XyCY+xgBtx53dN3OoPtR4YT2zhgxYyJU+D9oOgXEZIoDze
    5wwQ2D2+CCLF9ilQIbrCsI+ikHtGZe+pvWUkXnK5/+turObao8O6EmMpeXS9Ryct
    fdHq/fX3Pgk4XnqEfsstm7CzRwseDBugxeT3mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519694618; bh=l6eh2hC
    f4Mww87R79V2jqhFIjZLcrw3jAQOBQScwsE8=; b=w75OGzHgmvohdJt3hMjjb3r
    JRa9+77p6jla0fKsEZ+CrMbrXJpgzGeOJWA1D3Br8PDliVxtnFhFW0Fs4b/gMANm
    Ls/f+O/GTLy4YiP/MgBVmezPeMVeROrD5Fwy34/ZnRk7oqr5gMZTxsoHeFmgCqED
    +nbCd7wc8vicTHQcIfMNNJolL4cLn5LyOBJkdFDfXwpqHRLcmMxMQN7BSF5Ghfvh
    3xV71t6rH9YoQ6LFM96mCAX2uKu93F3UhRR+fN338Du331r5+vypV+YJQSyzZF6m
    IadR1emd8bsSvcPLe9wMbsUWqCnmTGSjjSx8HMdMpJ8Pdamoil5qCvZxMgy0wbg=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeB0BXf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 20:23:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35478 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeB0BXe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Feb 2018 20:23:34 -0500
Date: Tue, 27 Feb 2018 01:23:29 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 01/11] fs,security: Add a security blob to
 nameidata
Message-ID: <20180227012329.GL30522@ZenIV.linux.org.uk>
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-2-mic@digikod.net>
 <20180227005721.GK30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227005721.GK30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 12:57:21AM +0000, Al Viro wrote:
> On Tue, Feb 27, 2018 at 01:41:11AM +0100, Mickaël Salaün wrote:
> > The function current_nameidata_security(struct inode *) can be used to
> > retrieve a blob's pointer address tied to the inode being walk through.
> > This enable to follow a path lookup and know where an inode access come
> > from. This is needed for the Landlock LSM to be able to restrict access
> > to file path.
> > 
> > The LSM hook nameidata_free_security(struct inode *) is called before
> > freeing the associated nameidata.
> 
> NAK.  Not without well-defined semantics and "some Linux S&M uses that for
> something, don't ask what" does not count.

Incidentally, pathwalk mechanics is subject to change at zero notice, so
if you want something, you'd better
	* have explicitly defined semantics
	* explain what it is - on fsdevel
	* not have it hidden behind the layers of opaque LSM dreck, pardon
the redundance.

Again, pathwalk internals have changed in the past and may bloody well
change again in the future.  There's a damn good reason why struct nameidata
is _not_ visible outside of fs/namei.c, and quietly relying upon any
implementation details is no-go.

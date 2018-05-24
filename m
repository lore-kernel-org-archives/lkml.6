Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2597100-1527198388-2-12780233104766570850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527198388; b=eH45iqNq7wu1jfNxJWWbQPZlnHu+Ihj5amQSo4PzEIjE9Bgz+w
    5DeWiMjtrADFbLtdtHYr0ZOQBuz0Z2BYY2hU0YoAg1TCm9B+mU9eHwCsI2fSMSCz
    zEtzh50VuIYz1bXi58bfYVDdAQYTadYpEBeWAbYqhEFQYByw1IsuphRl1DiYVyF+
    XfF2yRkRjSiuzNXfV5j/ecwi2NeqCn0XmcQ0+Ne5eSLYXeRVJDWYUpu4hk9CaoLR
    FgtpzDDyinb9SnH9NmmTP1ycfP1jnoC37p8ftT219UzYr0WqTlQvM9c00kFQ2arU
    wppgq7lkwtgyiWQighlaZ2Erys5wAwI7OTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527198388; bh=Y1NO6D6gMsUTve1RGJB8rnXOnfVJyA
    NxsjyXo5sISpI=; b=mGxH10EULllAV6B0mwg+3a5pUUYdTWjt3MlKgygh4gsXdd
    28GKIH/SSFlGR7Ro/HkexGd56kWy/5d9qUpR2z8Bk5CkG1m/Ex3K0+7x/BzJmlYx
    6umJ6mS/wQmGFUhRKW2mKtvfHqMShxoWxWnt7vxHHdJFEld9M1T3O4mNeOuPHgB+
    g2yNdhc2qVMQhQHf1QBgzUBcd7vLj8GL3SCZ4CENk/6Urt76otg0Io27CPZgaTpj
    +rVoQFyq4xkM5NUJns6tmWggN0rJQ/EttGlXxP8AGO8yJ3lAZIfB2qbygMU6+RM4
    KMZxRCPvm2VquCr17jzCH4raMiUaUy0Xfixfvu7Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=Y2rVLSYL x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=Y2rVLSYL x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEeH0tlFyCf05iZM5rdy6nm4XEoH+M5ZKyoIkDhiyVXXh5V1gN2fLkHVXOgbR7O9MyG3Np9IyV0DtfBjzZdmhVurl6d7o8gnLc56zS16hmRS2fNmmLNG
    U2UxWfKoZ9p+8cuDGTdrawjJQH94bJPe8VGRePZ/HDl8xLqYW6IYi58reag74IHg8p+QRpGOVULxHTDVQrCoD9X5W/MdDoEssIA94/0UZ0WHap+nWF3FGJd3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=kBbfae25BXJ4Mxs6ue4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970058AbeEXVqX (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 17:46:23 -0400
Received: from imap.thunk.org ([74.207.234.97]:52188 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966099AbeEXVqX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 17:46:23 -0400
Date: Thu, 24 May 2018 17:46:17 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 0/6] Wrapping up the vfs support for unprivileged
 mounts
Message-ID: <20180524214617.GG7712@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <87o9h6554f.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9h6554f.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 06:22:56PM -0500, Eric W. Biederman wrote:
> 
> Very slowly the work has been progressing to ensure the vfs has the
> necessary support for mounting filesystems without privilege.

What's the thinking behind how system administrators and/or file
systems would configure whether or not a particular file system type
will be allowed to be mounted w/o privilege?

					- Ted

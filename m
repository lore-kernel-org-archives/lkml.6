Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1528056-1521028631-2-14011806417957447973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521028630; b=wP6IKGSVZwXS5hqjNIUhZI2Ag7tDQ9wQYNWcpVxRXCYNeJy
    0eAZQdJtZwEXVHl73Zp6xI7McqSyuJSxBEEtgXS70ayHCUSGCE9c74uI+8Z38YNn
    wILDe89seYAHGRc/eT/jYTqTBkVDIBJQkXTdFaXcsc36L6ZQ3tET46JzOcHIKdyQ
    VGXVypmjGaBTHqGTd/KSGn8Qx1I6McH2ArxVxUVBfYF0nqLDc1vtFHsmnWsYCiF4
    s0WHWh/ZkMbbjuKf0AQIAMyHn8a4nqN9/pmRB29uk1pJuqrZp9+3q3Dws7Newauv
    fKBpP8g+/lXorBpaBimtLdAg5sXyf+Z5hsltBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521028630; bh=o
    Tlm8wjcQyCE3jDBtfuAE/PptjyfS1NO3lujIS+Uu7E=; b=bkxvABugY+2gRgXr8
    eOp77aTAL2kNdVUtjRhNQKWK4N4UJMEwSPgXNNRIk1wNSWFkhiIlwU3wWvNMw0rV
    o4iiMG9FY8IdpBkjohb7a+yetfPuvIqXo6zf5RK/4dbm1j1iUIX94ooZNpqVugMD
    2JlO/ihm61QRkRiwpDB29HKrHQV5GqHgAWZeEhftls7CfziThArzg/hbtW+p22HZ
    LFT6jAAvkaAZ/gQ0Qfvt5ewKAzYb5pHIfQ9IuhJO/dRzoOwcFSNTyTHWdb0dIDFd
    cYWbSb/ZmIvbVXhVTOFCvpZeWFCiD8Bw9QQdtHBSi1h+3+lKDHSOZZbXeNNsLWvI
    zp7Qw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 12:55:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Oucharek <doug@cadentcomputing.com>
Subject: Re: [PATCH] staging: lustre: o2iblnd: fix race at kiblnd_connect_peer
Message-ID: <20180314115546.GA14792@kroah.com>
References: <1520581758-4410-1-git-send-email-doug@cadentcomputing.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1520581758-4410-1-git-send-email-doug@cadentcomputing.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Doug Oucharek <dougso@me.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Alexander Boyko <alexander.boyko@seagate.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 02:49:18AM -0500, Doug Oucharek wrote:
> From: Alexander Boyko <alexander.boyko@seagate.com>
> 
> cmid will be destroyed at OFED if kiblnd_cm_callback return error.
> if error happen before the end of kiblnd_connect_peer, it will touch
> destroyed cmid and fail as
> (o2iblnd_cb.c:1315:kiblnd_connect_peer())
>             ASSERTION( cmid->device != ((void *)0) ) failed:
> 
> Signed-off-by: Alexander Boyko <alexander.boyko@seagate.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10015
> Reviewed-by: Alexey Lyashkov <c17817@cray.com>
> Reviewed-by: Doug Oucharek <dougso@me.com>
> Reviewed-by: John L. Hammond <john.hammond@intel.com>
> Signed-off-by: Doug Oucharek <dougso@me.com>

Your email address here does not match the From: line :(

Please fix up and resend...

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

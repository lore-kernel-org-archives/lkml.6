Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-257181-1520337580-2-891036887656053882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520337580; b=PRFi4j/yi1sj5VDIyPjhrnGNMGWUbyYuJwbt0SPWO0uC9eB
    PvNjdOx67VN9Osf9j5qX4F6nTKEK++ZRuHcTk7zCfNKoyMYhScU/y+1PeIM6VzWn
    szXxMLjnpRoWuSMfyDiKKJhexM/OWmFtSBYUC3VSvOJzZ9yRYP4ahkYk9PwCVKkV
    aqt7IgLhpbzE0Yeu4QHsy5hzowpo0a85f4Sz9XiCN14sWxzfCSLP3oFvQvkpnvrZ
    t58vTgV5+JXPbrt0FS/xF1GbjekTNr8S9AMogx8R5w4gAhrW+q8gXHOB+hRjX3JC
    +l1UKoJxg9xnQ1kA5/Mwyiz+BGjVPVFEE0EjAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520337580; bh=q
    ZiHJUXi4iaaabjLMr4NXJdJ92tcdtLz/kOHxG0N034=; b=QbJW6da9DOOAZZ2eP
    77iq9VewdcEp2rsxsBNRYT+FNZLHacsX3/dzZ3uoVbihn6rJ0UdtkiDn9tKWcK3s
    NVmewm+8/7ykgskf88+9GzAaV8V/MhNxCBkASEZOD4EkEWUCTLdqTnbIGJvYcCKV
    PfxJ+gpkAWpI37rqcbZ0PupvCWoOh3mACyERgilpMjQN5L9NeX5al9wvJx0kQ++b
    rMHwdhwVab9qQOL5cOdedOSduLjSMHGkJbPdmniGUpWQ7Y9aUjyFi4QPFSS2vWeS
    tLx7AxqyjuiecNEDVtqoMIyCM1d+6FezS3dgC6iJEUDGoB9hR/HcLRqqrgPbmGhn
    CMSSA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 6 Mar 2018 03:59:35 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [PATCH v2] staging: Replace printk() with appropriate
 net_*macro_ratelimited()
Message-ID: <20180306115935.GA17888@kroah.com>
References: <20180304204910.GA4840@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180304204910.GA4840@seema-Inspiron-15-3567>
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
Cc: devel@driverdev.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 02:19:11AM +0530, Arushi Singhal wrote:
> Replace printk having a log level with the appropriate
> net_*macro_ratelimited.
> It's better to use actual device name as a prefix in error messages.
> Indentation is also changed, to fix the  checkpatch issue.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *In previous version printk was changed to pr_*macro(), which is used
> in kernel instead of calling printk() directly. And for drivers,
> dev_*macro() or net_*macro_ratelimited() should be used for calling
> printk() directly.
> 
>  drivers/staging/ipx/af_ipx.c | 14 +++++++-------

Please read drivers/staging/ipx/TODO

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4134551-1520846373-2-10186809404344985652
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520846372; b=sXxQQiWiBw3mivLNv/lsWpx9S3Gc4Jmgsnvo8bVvYSRWAx2
    YJW4BC8rEauJvR96V4kEOHuHG6JzUiX39iqJF3kQAE0EpSAVZMY8JH9MlKKzX36Q
    lReSh+pwUvPfg1gr2lY614V0UrR0SiUj0Xpm8QAgRBdTHl1K945TzsBjTqPSWaGb
    qX/zpbnyWejxDmOSYMtMYipIlBOq+DBLD33hAbUBakME42aYAoaG9dS/ud2Nzyxx
    yjX7WIUqHlAfspYx7mcnK3JnqRNPHTx/N9EhNI0t/0XkxEaoxWOw/BrKu1gl6YNT
    AVgjgGVNjtYLNwLsywCH99dO0UHZL1llpelFoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520846372; bh=9
    eoB5gOvie77mfAWK7VK1Pz1ohe3t4S+2FnbpwGkrM8=; b=Ah+cwHK1g/dmF7hUu
    TnDikkF1lByWUnFb5oY/Gp65GLHkv/m+FGHgeJ1p1utl3ipZUILlTi+ed9uNzCpp
    HjjdhKgetAlhnRWjy2/CQpZbV9vIam2Y6UDXLDlI+tc65PN6MU3tdSQTl9WSqDpi
    Z11sLipBjgItzoa4141/0IyhqHmkQmWNHGlGybkDumicBBzv99VfQC3gD9sl38Tv
    YXajUObOQXo3/TDLKoTTVtx4Mjrxi4G+EpyiLbbWssp7Mzk0YpwTEIr9PVfDnfTh
    cONcTSkJpfCLj2H9N3cbkCTl3jjfPMbNGJDACk/Gcm0vKL+DSYGmNeuy1ETfk/6O
    Ou2rA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Mar 2018 10:18:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: mikelley@microsoft.com
Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Add hooks for per-CPU
 IRQ
Message-ID: <20180312091828.GA4370@kroah.com>
References: <1520826542-2095-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1520826542-2095-1-git-send-email-mikelley@microsoft.com>
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
Cc: olaf@aepfle.de, sthemmin@microsoft.com, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, marcelo.cerri@canonical.com, apw@canonical.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 leann.ogasawara@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 08:49:02PM -0700, Michael Kelley wrote:
> Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
> are in the architecture independent setup and shutdown paths for
> Hyper-V.  They are being added as staging for upcoming code for
> Linux guests on Hyper-V on ARM64.  The x86/x64 implementation
> is null because VMbus interrupts on x86/x64 don't use an IRQ.

Please submit this _with_ the new code that uses this "hook".  We don't
add new apis unless they are actually used.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

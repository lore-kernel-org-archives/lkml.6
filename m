Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-340991-1518792518-2-11147160878357163944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518792517; b=ja3Zxs958+Z1rKBtMcTuDgAGC1KnfRhY+piE35NMd5VDmDS
    Zow0TiA/FYxHJMdzQNoBLSgjANJSCdqnbbwd8tVBXCcKGoHtzgQIHh9oNCaGTWoE
    uyyslX/ZMprE1IuMcy3TsUZndSDTYsn9GXKN0aPZVMPiPtP/tuqkNutMO4N8lkD+
    o4cKZ5hBMWyCPD3ks9NFK6ZvuigtNnrLD3nxB8Oc302eFtdNfAUJzYqVSqlqEswF
    aIe697kzb6CroeFWvIvq6lQLa5i0Iq9i2wFxBpHjnuwml3bLpBP9rqFiNE2pte2U
    PDYc+4WXy/KCh31FYY5CGvwTqK8RI6QMqFP1FBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518792517; bh=1
    MqCk8NlYYhtr9UccU9WgcIKklf4Zkg5OLes5+LUJ2c=; b=kGik+2VWrnvNgNvbT
    22bvU36OaO+p0EwN32NFgyeuBpzNzGrzHpuuO8mu5/ePypeyY1oY3wcir6ByYPuY
    pmON3rBAGJXBpaSZ/+JiT7aF16PcWjWnyMlF0KdKbdWkJ9+Wm00sKT7mWuBM527s
    b233EAIQsO1fY0aWvZWhggDJ2vhOvM4zFwfsRSds50wyFU8V3SemYsoNjyEAevKO
    gP6SN8QlJaM5Z9rzYH6gukhk5PojHHwcunot+/ufWajhuVUpM+63U+k3dclx1BJI
    8I6GtsV4FNApm3bRaD0TB+msMABqVAFuYxY0QyuF88xIyc3At2u1+sAta6IrsW/m
    VpwCA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Feb 2018 15:48:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefano Manni <stefano.manni@gmail.com>
Subject: Re: [PATCH 1/2] staging: rtl8712: make unsigned length for
 rtl8717_get{_wpa_,_wpa2_,_}ie
Message-ID: <20180216144819.GA10052@kroah.com>
References: <20180201191453.4611-1-stefano.manni@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180201191453.4611-1-stefano.manni@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 08:14:52PM +0100, Stefano Manni wrote:
> Fixed r8712_get_ie, r8712_get_wpa_ie, r8712_get_wpa2_ie
> to have a length as unsigned int pointer instead of signed.

<snip>

Can you rebase both of these patches on the staging-testing branch of
the staging.git tree so that I can apply them?  Right now they have too
many conflicts.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

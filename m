Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2452599-1519373851-2-6879337414935622976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519373851; b=dW19aePfGHvMvzSoSw5gRAwFi8U9jbrlCGi4VMIC/VAD9uf
    6ryP0Y/U1WRjJAHqmUwHPG+gjRwe/IPxgmUFXe6pIXW9oUx37MhpUEWpWrULoVsn
    8pq75Xv0DFQUxY68Tcr1aA9LJJD40XEji/+dUMgundvj8XeuQ6ZTnW2Y5G0afm9f
    YUvmJ41kUr8nsTTq7QnkmtZJMlH9WYFBzw4NJSYKtFf5VAnbDuPTe8nWhMNVTfqm
    w9pXYPLoSbQ9f6J7HgK++Ytwi0EMaXSbYikk2zvs9ofen/rKT5NG1AQm3Pb/yAmF
    nZ/RacBhjwvhurKEjOCXFGYeOcF8KzAKAb9+dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519373851; bh=p
    i1mF/TpJ6Mt7otZhc/mUl1Tejvf7EVIcq3bcH7iwIA=; b=QVyLgHPAwHiDu2vGo
    VKlujKeQ76o0PS4F2XxsNHXx8UFPod7KsxtVVGPJCR81lmC+eTmP1lj9v6xFm7WS
    3+AwCoUbO5XXJNgR6aYVkCWBuRFu8XT+ZsBtJr5OwpEMBgzADQ72SXlFhEP2vyUr
    XlDHLbYLR7RCY9CmTvuv2AMyo9OciUyuOavWYaGE7Kgcgx0RsSK34ynoZYKYaPR7
    BQiL+KlhFlDp09aN5NhVEpFTuKiMi1EPhzyKF0SNc5JJFfRvFu1xhiuvgfPwDDHV
    lKpBKxOkPyvyNSC1QF6tneFgkWA633A5uuhLpE4XGa5TGpsVioCgJsukOGqDQnj7
    U7CIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Feb 2018 09:17:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Debopriyo Ghosh <debopriyosoftdev@gmail.com>
Subject: Re: [PATCH] Staging: rtl8192e: rtllib_crypt_tkip.c: Use __func__
 instead of function name and proper code ident for else statement
Message-ID: <20180223081725.GB12617@kroah.com>
References: <1519327636-18972-1-git-send-email-debopriyosoftdev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1519327636-18972-1-git-send-email-debopriyosoftdev@gmail.com>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 12:57:16AM +0530, Debopriyo Ghosh wrote:
> From: Debopriyo <debopriyosoftdev@gmail.com>
> 
> This is a patch to the rtllib_crypt_tkip.c file that fixes 2 issues found
> by the checkpatch.pl tool
> 1.Use of __func__ instead of function name
> 2.proper code identation for else statement

When you have to list different things you are doing in a single patch,
that's a huge sign you need to break the patch up into multiple ones.

Please do that here.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

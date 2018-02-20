Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2727985-1519129328-2-9300188216757926509
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519129327; b=fpPNtjIRMqKMubZ3syY0VPG8hbahEavGuby3B64kkFgCIzM
    BxCmzkLBLBdudZrKTm+IiCMhFn9tCCc+9vq8oYUgQNn1L9Sq5z0yekHCu8rQS0C1
    My6HeiJ2AMsxwQ2JPU60tZEadm6jagueBhi7NxxV+plZfihXgzjgd/AUqiUyDUtM
    0DDW//tCtL24DrT9xv2FT2LwINcwmqm2CVDrzdH9WYjMF2jTFPTjDMwmPRMXV74A
    VYflgdBe7OaDe3od/+uYXSuw4lxmmNZOYzDiQR8Ife7SgHnTwmLrRQgDhrXFsYiG
    If+IAUVB/n3KZ6w21UbsZstuefI3A73/NldgM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519129327; bh=h
    OPNQQ8eXtYil1CNguSfq2cpYZF1269uNKaZovqXNXE=; b=pXXwStSviWrY/yq1M
    pABwmpEjwkoE/Rl7SfbZVV9Go5tFyArbbUv3XxY7lRreLBj7/c29hQ4KqPO0tYNE
    zdXDDtN61JQMCoq75mrSmXAxnA3DMmvOIk4xrHQB/Re11YKxwHpKvk7rfIY/cZ/i
    W6DD9Pa2gHlft6WGDuxEuVVPo8CC7o9TcYfj55QWJABQgJBDmgs4JTarJYjy+qYw
    2r92VxY/+YNDn9JfjLSgAVx6SKERwAtTkZwsZNnAekG425RAyE7vDRHqSbbh1dBT
    y8fNG+wcu2anBr7vz3NsQsc6Qcuk0zLh6+SL2oQz/msiG/2bKCeRuy7rYGXJ0IE6
    PJwUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cUj4amcx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MHsHipWy;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cUj4amcx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MHsHipWy;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227ZXne5GziVKNwE/PhaIfHZsY7qWOK5KJNacJi24H0qnpi8kpYJbMHTF6M68Bx8SlWkG5H3FQ==
Date: Tue, 20 Feb 2018 09:21:56 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging:iio:meter: Add name to function definition
 arguments
Message-ID: <20180220122156.s25laa4wgcf3hxuz@smtp.gmail.com>
References: <20180219162832.qbkogggfzwbgsqlt@smtp.gmail.com>
 <20180220072442.2oxvhwequzzc3gz2@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180220072442.2oxvhwequzzc3gz2@mwanda>
User-Agent: NeoMutt/20171215
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/20, Dan Carpenter wrote:
> > On Mon, Feb 19, 2018 at 01:28:32PM -0300, rodrigosiqueira wrote:
>                                             ^^^^^^^^^^^^^^^
> This looks good, but you need to fix your from email header.

Thanks for the review, and the feedback related to the email header.
I already fixed it. Is it necessary to resend the patch?
 
> regards,
> dan carpenter
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

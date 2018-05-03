Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3120198-1525380794-5-18325840905434411497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525380794; b=R/85Uaob/bXhojrfhNKYnqws28uWH4P+bT91GebxzUhFx0ITj1
    E05jtE5B1J2JUf4KN3NxtiCrhrYs/iKIOL5O/kVZVYC89ohI6RausR5M2quzhI0+
    0hsK0w9n1RpVoE3SlU7h+YA6cfd0XY5FX+ZGtulqwZlHh41OGGNyaWSMFIr3eV+X
    +zQrshGEbag5tLrS10q3MmJGDddq0yD16YU2+GK2x8H2bym2xr3xxCKVxRiZqNyI
    fdGIG97xcDHd/5BAH+zz6+PhdO7huHVsQ4vMUtIi9gIEviaGpoeRHMYlX2YK+uiV
    Y2H6VbeYxA7NYygPQg62QI1Ozm9fCl8f7v/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525380794; bh=NGz0O
    RNHvJ57iI8aycBZntccD6zdvRfuIKFR2WGN2lM=; b=S2WzEUSnj/XXicQW+2o9X
    jzeEKOhd/WISAhAOtz3jVN2LuzT/vtRSZ7QtXbaMMLdykoUBru+diW0vpLpCU9pr
    6q4XzLLiMrHL3MuAS0ZBde3CwS2l76CO78tGhrHUaawOotrz2QbkHY3TB4li6K4X
    2GRjEHamGFREkCn8UTHc39H4hlmUJJTIG8TYIaJ8TOSk7kXpTh/n+gblt5Mt3QIu
    84G9mte4hj5XVkW1Fyi8OZuai/9JMoZfjg6DWTJxPMTo2s4wtPMCW8NT4i9hOtKl
    qRxjtGjKVjvHs9/NuJKgRinAQaUoL+URQhqgJsD5dl/Fp9zRoVWbKNWJTcsaOFHv
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=RpFziXYQ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=RpFziXYQ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB2u2Y0B1zwhb667nkOKz5Yc2HwPuhu720acO6+KbsJjr7PPEGeLeD3E8IHHuH5eTTaomQ2aelchPYbeOW+zdwpm4EBfX1VGpjQT79YZQQeCPRECsfQb
    M/6mUhVwxM1iRoGT2bxuaEeErDwaBPkgoHHAk3aL01OVu/wOOEWTWrM/Ha5o3plRMjDkXnB8zRD0mkbRcbRTYlurNIcAEi4RSxYVGB9j4AwoTWMdTlHjRsts
    4yO5elPJHO6qvrCe7Gcd/g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=n8i27M1mAAAA:8
    a=1XWaLZrsAAAA:8 a=lTbjQzD5AAAA:8 a=DDOyTI_5AAAA:8 a=Q4d8F40EPhmmkEFLAHcA:9
    a=wPNLvfGTeEIA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=w8YF5asEQ23juLwKoPR8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 3 May 2018 13:52:54 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alistair Strachan <astrachan@google.com>
Subject: Re: [PATCH 3/3] staging: Android: Fix sparse warnings in vsoc driver.
Message-ID: <20180503205254.GA26297@kroah.com>
References: <20180503044616.157167-1-astrachan@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180503044616.157167-1-astrachan@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>, Greg Hartman <ghartman@google.com>,
 linux-kernel@vger.kernel.org,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, kernel-team@android.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 09:46:16PM -0700, Alistair Strachan wrote:
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hj=F8nnev=E5g <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Greg Hartman <ghartman@google.com>
> Cc: devel@driverdev.osuosl.org
> Cc: kernel-team@android.com
> Signed-off-by: Alistair Strachan <astrachan@google.com>

Normally I don't like to merge patches without any changelog text, so in
the future please provide it for all patches.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

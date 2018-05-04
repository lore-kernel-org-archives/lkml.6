Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3708553-1525412076-5-3480900228601205071
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525412076; b=dy2pnItJM7aqpW0bh/3rtiz6+Jo+uYIxGPSh5xx4MvT/pBdOxZ
    WiWQr2YCwXqviviCS344YN5fiIwq7Yj7ByPtDknDmPTjUn2n80VMn5ZGQAJ+9G8J
    3oeD/dd8n55MKc3A+N3f7wLHYJ59vQ1Qz0kYo2iXPz97CRrcMEPsK6da1zp4YeWx
    NBrd1UI2rq27GSrEP6zpSbNFlAvwomga1FNGuxWOniBk4wOBT6koF7//KBbRKTPU
    E88B3o8RftWKZNgzVaezil5/pIxmLtFhvJrxq2wjk/8AsGTO4tM2UVGBQisaYk06
    hg8j+W66A5BCuFTxDjGDinLKgG25CvZ9UBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525412076; bh=HOg2z
    J69E6g0FeZInhBe4S/hDhJKxlEIKfMyVyizFLI=; b=meKq4xn0fSguOu5pnszyh
    q+kWbrbkAHsFJN072+1rGDZ6XNPdOQMk46cl3z3cVSW3is5HFzgZiWqjZ7ej3tPN
    /5SRLTPEwqvYXC4rS2egf1eciO+bPDi7Emm66taE4P9qxcbXg6vbIeo+Z40roNwf
    ySN083b2gvnsYcsI+2B14gJntACrx5mnz2tzgs1kXIBfIUhkka+TCj9xvmKcDSR/
    UCU//cwBRuF7Svx6PqfMoG/0TaHdznRzv3IzSLICaU2s+O+geKCMLJgYSlb+X2uq
    +PQRfPo9xq89jRd6rrrmzhKDXN9n8p30ZHAPRD8D2vRX5y02R/J9YqxdZ5RMi3lA
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=umn.edu header.i=@umn.edu header.b=mpuNMmJq x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=umn.edu header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=umn.edu header.i=@umn.edu header.b=mpuNMmJq x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=umn.edu header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJLkgk1qJvIoCUFbF5+0j6+evEFCBJa+Mu9hETWP2YsqnxojW7a/WuDBwhPhvo3h9ZuiLi5CayNsWTrKqgBaT3AS9WHoZHjT3djgG+BpLsq/S9Fol9Ax
    ycAW8kXV1zn435vWgmjxCkqWTvjE0KxHK8q2y8K16G4peaGAsuTyQTvknQJIym26BOsXALiNnXzarkThfyN+vj3jQP8Kt644BYaWqyJsWkWXhbL7SnjZE1qc
    NR360uOQ8WCUAWTcinx1BQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8
    a=DDOyTI_5AAAA:8 a=bzfWOidBvO3Nw-Zo_TUA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZodVR3alUz+60KGf2s1clmdnPDlilbqbwG6s9iv3jVBcCj+Vscrnt2eijlM0/3OH3mNAMfstDZ56xoIvkTf6ww=
MIME-Version: 1.0
In-Reply-To: <20180504052731.jkwhs4h4fuia3pft@mwanda>
References: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
 <20180501084621.jfxrm3qoqfmftnxh@mwanda>
 <CAAa=b7dHK9grwfFLOpVv=Wpv32mLS66CxXJDHOzNBNaqsWLXaA@mail.gmail.com>
 <20180504052731.jkwhs4h4fuia3pft@mwanda>
From: Wenwen Wang <wang6495@umn.edu>
Date: Fri, 4 May 2018 00:33:46 -0500
X-Gmail-Original-Message-ID: <CAAa=b7cZajzCvZvzu7hnTcvGoxbQN-YVMLvbEGGR8v10AMC4rQ@mail.gmail.com>
Message-ID: <CAAa=b7cZajzCvZvzu7hnTcvGoxbQN-YVMLvbEGGR8v10AMC4rQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Aastha Gupta <aastha.gupta4104@gmail.com>,
 Roman Storozhenko <romeusmeister@gmail.com>,
 Andreas Dilger <andreas.dilger@intel.com>, Jeff Layton <jlayton@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wenwen Wang <wang6495@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>, open list <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 "moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
 <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 4, 2018 at 12:27 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> There is no security problem here.  The user is allowed to choose either
> v1 or v3.  Using a double read race condition to choose v1 is not
> going to cause problems.  It's slightly more complicated than just
> choosing it directly but that doesn't make it a security issue.
>
> It's a bit like typing with your feet in that just because using your
> toes instead of your fingergs is more complicated, it doesn't make it a
> security issue.
>
> regards,
> dan carpenter
>

Thanks again for your comment, Dan! I revised the commit message and
removed the security risk:

However, given that the user data resides in the user space, a
malicious user-space process can race to change the data between the
two copies. By doing so, the user can provide a data with an
inconsistent version, e.g., v1 version + v3 data. To improve code
readability and make static analysis tools happy, which will warn
about read-verify-re-read type bugs, this issue should be fixed.

Thanks,

Wenwen
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

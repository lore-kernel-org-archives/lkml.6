Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2980246-1522937862-2-7290690996181297264
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522937861; b=PQbPCmD1vpeNhi3myEk5d0Vpvgrf8/ymQXKUc8KY5KnuUsFMM/
    q6gm9ShJ/0IIBMyBuNYSoyLJXsvZg0UKmWlLVvRNCdW2+Ws1VYlWyo4tSI16XzjK
    zrJdY7QHBpXN73jZS9KmxEceORYrwZzJ25rJr4hWPwvgTKU0qb9IuYI8/DovB9gZ
    YhZi+VMqIGTeNhJP+vSBQ54sl9l35rasu4LbDPb/un6i1VW7EI71dAiwHQToFRJv
    Xq1ZfY37fqvph7iFgXHjG8JPweLnzWpaxzQZEiUUuYH1poMQLQgw0OCb8xWVBTn6
    1sPqXbd8AxEphkxThuFpUtyQW0osxqa/130Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522937861; bh=xzvab
    EjXAGhwNi9NubrmluRqLGCpHWwTMCGLBdkNrQU=; b=JTBfRWIK0IY5UrALMxSgL
    b4w2+LYgCuIFuc5WFLlryKMRZM0PHlqnf8ai54SRDAxoaPvfn7P8Rs5slRniYEYm
    c3hm48fWP0CgKfWppGmr+4aQMSy3KYDAawP8c6xtJ67vbRelXT6bsAxtrE4uDWyU
    hoPHVyJwoi2RIg3YVeTeTTOt8Cvf+l202WKsvFTf+hHujuS3ipGjzgLh1PAjZ3O1
    g3oimHXPKpqvJELxGztggAc/G/mocmINGnNDBgb1ZXT/mfJxos6WtDFtSKI5/rtf
    yB3FuWLESSAW7BXmVvV1NQD1tdnmijDkPpcO2t5Ww3tyWJqtZ41wxzLnQZk5DDMo
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD2b4U+/2jvyMcIKIGd+DNu+5TCBNHlItlt90r8SIJDVQgagXcSBBDTAsrGp+iIJOeWUHDAD7zpCdfkOfzh4Tos8ONS0UjIewboIcohkPJ/LITScRSjf
    vWSk1MjmcY/DxFpD6aLFsYp0hGQT1AOZmUgg/Weu1Yb1bH9a17ZNCHT/WzS1poldpKKfsG+rAaq0m8YjoG+z5batZPu5iGwfBPiP4VjV690eGzf/kKEErM3A
    R7bAbYvpGZatG4dzYNprjg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8
    a=S-H95JceCtZQwh8adRYA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 5 Apr 2018 16:17:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Staging/IIO driver changes for 4.17-rc1
Message-ID: <20180405141734.GA28680@kroah.com>
References: <20180404103219.GA11115@kroah.com>
 <CA+55aFyD_KAqxxNSg795Z+49gimEU09MpfCKd7RvLuhk2vwYsA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFyD_KAqxxNSg795Z+49gimEU09MpfCKd7RvLuhk2vwYsA@mail.gmail.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Driver Project <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 07:00:14PM -0700, Linus Torvalds wrote:
> On Wed, Apr 4, 2018 at 3:32 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > It is a lot, over 500 changes, but not huge by previous kernel release
> > standards.  We deleted more lines than we added again (27k added vs. 91k
> > remvoed), thanks to finally being able to delete the IRDA drivers and
> > networking code.
> 
> Hmm. The irda sysctl tables are still there in the kernel. Overlooked?

Ah, I missed those, sorry about that.  I'll include the removal of those
bits and a few other documentation removals I just found, in a follow-up
pull request this -rc series.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

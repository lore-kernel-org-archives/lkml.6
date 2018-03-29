Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-190428-1522308324-2-4944864654283877885
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522308323; b=M2c+uT2zy7RKbrxOwBADJVfJwbhUHjBQxmK24vvDXaQrecF
    py0UVYSxknl6Ees/+rosF3hJkUmSWumfgyR0L/OG68Fwmqd2JMZfnPMpnC9lbVSH
    teDbyvsxzzqWcprJfMxCB6g0s7zs3VW/M1SB2aXjwqzvN+7G2+yd7iQdgb7qzASo
    +Urs6/fvJxcOuIiKJ3RXvLXikhV3fBZzTKyO1NVgKJumHKJpgBOe5FA/zPvB81eZ
    VOiLjjRauid69NlJzmpeOREUAz3J6ibEUSVY8e20+iKpjNjBgK5lwLINPxNd5ScZ
    U9Px94cp/d+axcglUYynTmAAjcvEIIMBmo2XlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522308323; bh=I
    jiy2uEi/vdSkkmDEXNbDmQWRAtPKSCt59hyxCLrI4Q=; b=wQcD7hzC6k2gyf4R3
    TaRaSC9LvV1ahVdPPFW1+BJDEDU+bdLfE5Vkc0wJl+t5vbZn1xpI0E4bFb+WajvR
    zPovfGVxoXHUMvXgfTa/1MdPGj9pIL45fh5Vwy9kLk5LtBMUrUfW++w3W6ZwKg4C
    Yw38d7tWb7wSBrR16djjXfjDwXjPEX5D5BjNQKlGxNeXflQEfapSRnj4bVeBYclm
    zHiaZgCxpzLs5VX7TdC9J2WRN/NscQYpfrOaqPFLpEcG7+prxrSln95FJgUn1juj
    BGIds7MFI5sQ1EHaFyPwHE/j2RX4y1VenwKC2fq8yRXTgagrvSNO7l1vHrislMjX
    E6hRQ==
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
X-CM-Envelope: MS4wfJAve83O5fpy+v5pR5TQPcc59yILx4P1Xpd/PqxgEhJ1RuF8e7JEduvrA6Qf7LPqv+OX/y8bDi7yNGCXEHKqJZ7C3VWMu9n3aaFTdmZ0biLPupvhF3Bd
    WlSQe/avnmqlMvx0FeOZMLJi8+BvpsUP9/8hMYRWQiNwwWMjBy3DYP5zSVuFIX0AE0Jzw4wtgaUy3+sXAEe3hb/DT01L010UmcANYQNw4JtQKJbWx31s5EhM
    Iooy3rlWJ8mD4IXQddE2TA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=UqCG9HQmAAAA:8
    a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=c11wnXLowsIY3vp5NUYA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 29 Mar 2018 09:24:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix ring buffer signaling
Message-ID: <20180329072445.GA13733@kroah.com>
References: <20180305052408.19475-1-kys@exchange.microsoft.com>
 <20180328120142.7ba72aa2@xeon-e3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180328120142.7ba72aa2@xeon-e3>
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
Cc: olaf@aepfle.de, kys@exchange.microsoft.com, sthemmin@microsoft.com,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 Stable <stable@vger.kernel.org>, Michael Kelley <mhkelley@outlook.com>,
 marcelo.cerri@canonical.com, apw@canonical.com, devel@linuxdriverproject.org,
 vkuznets@redhat.com, leann.ogasawara@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 12:01:42PM -0700, Stephen Hemminger wrote:
> On Sun,  4 Mar 2018 22:24:08 -0700
> kys@exchange.microsoft.com wrote:
> 
> > From: Michael Kelley <mhkelley@outlook.com>
> > 
> > Fix bugs in signaling the Hyper-V host when freeing space in the
> > host->guest ring buffer:
> > 
> > 1. The interrupt_mask must not be used to determine whether to signal
> >    on the host->guest ring buffer
> > 2. The ring buffer write_index must be read (via hv_get_bytes_to_write)
> >    *after* pending_send_sz is read in order to avoid a race condition
> > 3. Comparisons with pending_send_sz must treat the "equals" case as
> >    not-enough-space
> > 4. Don't signal if the pending_send_sz feature is not present. Older
> >    versions of Hyper-V that don't implement this feature will poll.
> > 
> > Fixes: 03bad714a161 ("vmbus: more host signalling avoidance")
> > 
> > Cc: Stable <stable@vger.kernel.org> # 4.14 and above
> > Signed-off-by: Michael Kelley <mhkelley@outlook.com>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> 
> What ever happened to this patch? It doesn't seem to be in char-misc, upstream,
> or stable kernel tree yet.
> 

It was in the 4.14.31 and 4.15.14 stable releases.

thanks,

greg k-h

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

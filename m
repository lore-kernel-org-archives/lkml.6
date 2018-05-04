Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3611583-1525407626-2-8320352209538518606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525407626; b=Qci5d5FOuyj5+a58hMe+V540cE8szs3UWI1q9PKcxsqHZDubn9
    k7jWvQ2mJb+henP82JDn8AK/vzd1B+RmzkNnIAjeVpXoLDv2h9l80iCU8flhY2In
    X/KztXhvEsiHua1MNSuFiSEuJL2cqK2VA07npiKGQaL4pFPnr2CWFWK+uIMOQ/MJ
    j2o9H68jD6U8+d42DaF0PgovpCEher7RRSZLx5jfas6XE0Lkse42l02+o1TGia8a
    fom5bpfyeLaG0zCYcrj8n8Gk/fV27G38mc4X/yULd/stuIu/VPy82Ng9WeUDlbDg
    UdNNEiq7RZg3PKckv+mAvFlT1FFExSf4ujNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525407626; bh=DFQzI
    tfUnhTb99uDTEMOXGUAp6VmRBh0aELA8Oc6drU=; b=jvRSfqyk8EWwLPYEtlz2S
    5qYu/q8lgLGh6Gp8zWFlfYEn+x+XvZaeSeFsAKHyuUw1n4th9tFnoR/8B/jLKvWI
    NOY/Te738yOXwMsw3axjdVZRfxpQ95hN+ZhkzLo5x3znkPEAqx+LPy8lni+plysY
    eDsaodM9gV4G6j1lnfDSOXwBjzY2iLi2cFJaC76vqINqdk2NIdo+OeiK+s8fRh4M
    RiPQ/WeunoHjTc6NX4NWWI6TOlXT5UtmvTgVqlxyBJFDhZ2oLYiKOMh7DTH0uzkE
    JnqE8+AAYktMf6ey27zbjQF4GplJEYVqbEU1jAm5duHe1qgcOWhqPhwJDTL6OO5A
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=umn.edu header.i=@umn.edu header.b=Ez3RMwpC x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=umn.edu header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=umn.edu header.i=@umn.edu header.b=Ez3RMwpC x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=umn.edu header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLNlNVRsC0yRiRvG6ek1nzmVq+VJBMlD45XlmHuB05IbYu25xhL+1P/qvH7c6hlnZc+IMqgnYAeBFLDCZ8oQoLl76tQZIALN5REV4BZ4NBCQ9l52RA2R
    OBF2oIwCJ9cDd8jwmp8bTQzx3rjBPk+NmEhpmFASpyeGGGYJNXbsKw48cn2+DmJfjLWEnYsjcjQiwNjG4PsfxjPxjM1i6dDiZkldUS+ICd5bcrohYWflSNpl
    jLRwJgPdKupvoG3DynYQZQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8
    a=DDOyTI_5AAAA:8 a=pPOgiJgIYe2XS45olIQA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoHCwaVmzB7VdM+1m0JWeoyfi8Ri2GlOKyIcb6kttE2ZQKXEvbcq9gPL7VnJgMJHIWHYM3XpePf/YzaN/S8htY=
MIME-Version: 1.0
In-Reply-To: <20180501084621.jfxrm3qoqfmftnxh@mwanda>
References: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
 <20180501084621.jfxrm3qoqfmftnxh@mwanda>
From: Wenwen Wang <wang6495@umn.edu>
Date: Thu, 3 May 2018 23:19:37 -0500
X-Gmail-Original-Message-ID: <CAAa=b7dHK9grwfFLOpVv=Wpv32mLS66CxXJDHOzNBNaqsWLXaA@mail.gmail.com>
Message-ID: <CAAa=b7dHK9grwfFLOpVv=Wpv32mLS66CxXJDHOzNBNaqsWLXaA@mail.gmail.com>
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

On Tue, May 1, 2018 at 3:46 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Apr 30, 2018 at 05:56:10PM -0500, Wenwen Wang wrote:
>> However, given that the user data resides in the user space, a malicious
>> user-space process can race to change the data between the two copies. By
>> doing so, the attacker can provide a data with an inconsistent version,
>> e.g., v1 version + v3 data. This can lead to logical errors in the
>> following execution in ll_dir_setstripe(), which performs different actions
>> according to the version specified by the field lmm_magic.
>
> This part is misleading.  The fix is to improve readability and make
> static checkers happy.  You're over dramatizing it to make people think
> it has a security impact when it doesn't.
>
> If the user wants to specify v1 data they can just say that on the first
> read.  They don't need to do funny tricks and race between the two
> reads.  It's allowed.
>
> In other words this allows the user to do something in a very
> complicated way which they are already allowed to do in a very simple
> straight forward way.
>
> regards,
> dan carpenter

Thanks for your comment, Dan! How about this:

However, given that the user data resides in the user space, a
malicious user-space process can race to change the data between the
two copies. By doing so, the attacker can provide a data with an
inconsistent version, e.g., v1 version + v3 data. The current kernel
can handle such inconsistent data. But, it may pose a potential
security risk for future implementations. Also, to improve code
readability and make static analysis tools happy, which will warn
about read-verify-re-read type bugs, this issue should be fixed.

Thanks,
Wenwen
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

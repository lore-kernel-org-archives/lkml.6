Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-219062-1525443125-2-8153179863888375674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
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
    1525443124; b=cqPWGEQcqVbhF5dS8PHO6qzHTB6IDUnkYKWcdkfYPnszBk+nBV
    kt4jPfJvliX/8keIpbFgxps20ITGdPM9B/ALjkKqEdDk6lrkJEOlQNinz0ssxNgr
    Oc1AVEI40vF2DSkqcgaRuRWRcVi/rnkhXiRjqX2SzdW+iLW0WoHaY6muKc7AGPvF
    znngdMRJjlTKzdIZZbNAkor0QXgDD5DEx60kWHv3ZRcxr62wQQmiAIEa9NM3wh8i
    090xjte+L7H9991OZsaJ0YfkZm+bLPJjrP7rQbMph1665eTEoDxh0RQjcS+ddEPU
    CpHhbY75WTLdcXwGSvOV3R323DYJQiRTmong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525443124; bh=42SB/
    uAFzjAJt8iriKXGGRyhzZZJd3fH/C3DRKbUHX4=; b=i2WSmijaYHGzW+z1xaVvL
    t936n46AVTqmneIc/IWnvknf4AVuweuMIayn3X3/7DtHmRKfHbWdgVi4DFwL80r2
    3UxsbtCJ61axueiGiVeIV90SAGxmF/DHQ5oB0q4QCwWAfCoGvtLobbxiEz/+CvOf
    hWTci5BJlpMI3wdPNq3S0kuA9rsmAEF8VdR5+HpamDRQaRMUgx4rqZW8jv3Tjw16
    NDij3gvT/vh75MhH6t2G2vYS/kuFUjvZ+sm2RvMz/s153o02mPznjRrsvBdVp3ri
    1lPAVieNqyKC0h5snZl5wrGqCIGAEzUu7SPaC7nojhn+i50zcRMa0vEkMsyzmIHO
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=umn.edu header.i=@umn.edu header.b=tP+mwEKK x-bits=2048
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=umn.edu header.i=@umn.edu header.b=tP+mwEKK x-bits=2048
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
X-CM-Envelope: MS4wfPp/fJged/SBoaVuz5Dzsnsf8JsAJAO6D2vHaE048Z2sHolabg9OP9DZkVjly5XUdBSttq2pHVyEONBUGCCA4LFBZKNu6WubBhMoQu3HVvtO5Y+fhKCV
    ZPhsBpiCJqfMRYa3OyOv8FkCAALHQnlK/vfJLNBApjKJTPlEnocHFWCG5q90ATd2xMZlyV3u+Ta46SqBRMAOOWn2Ee/QWXFHh2TKqnKQW8V6UPREUzyGas8k
    dDEGjCm9kJdfEBZrztyYkA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8
    a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8 a=m8SWDWtqzq1BJKqNCeAA:9
    a=AdrJBZdeGXRL-yPU:21 a=1tVFFZFP73ji0gIN:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqYp8lKYFQuwXULqecXTb7PzgRcA/Eva0RmC/+q7TyA5MemgiCx5rg2k/jXvF6gMX4LpeY0Bzhbo0f6y1213B8=
MIME-Version: 1.0
In-Reply-To: <7185D89D-A0FE-4B55-B089-9AF0891A00BF@intel.com>
References: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
 <20180501084621.jfxrm3qoqfmftnxh@mwanda>
 <CAAa=b7dHK9grwfFLOpVv=Wpv32mLS66CxXJDHOzNBNaqsWLXaA@mail.gmail.com>
 <7185D89D-A0FE-4B55-B089-9AF0891A00BF@intel.com>
From: Wenwen Wang <wang6495@umn.edu>
Date: Fri, 4 May 2018 09:11:15 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fwS0Jfz6Ce7b5KsUtg+uNii0JowhUjtuQWHw4VhiA1ug@mail.gmail.com>
Message-ID: <CAAa=b7fwS0Jfz6Ce7b5KsUtg+uNii0JowhUjtuQWHw4VhiA1ug@mail.gmail.com>
Subject: Re: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
To: "Dilger, Andreas" <andreas.dilger@intel.com>
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
 Roman Storozhenko <romeusmeister@gmail.com>, Jeff Layton <jlayton@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wenwen Wang <wang6495@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>, open list <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
 <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 4, 2018 at 5:08 AM, Dilger, Andreas
<andreas.dilger@intel.com> wrote:
> On May 3, 2018, at 22:19, Wenwen Wang <wang6495@umn.edu> wrote:
>>
>> On Tue, May 1, 2018 at 3:46 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>> On Mon, Apr 30, 2018 at 05:56:10PM -0500, Wenwen Wang wrote:
>>>> However, given that the user data resides in the user space, a malicious
>>>> user-space process can race to change the data between the two copies. By
>>>> doing so, the attacker can provide a data with an inconsistent version,
>>>> e.g., v1 version + v3 data. This can lead to logical errors in the
>>>> following execution in ll_dir_setstripe(), which performs different actions
>>>> according to the version specified by the field lmm_magic.
>>>
>>> This part is misleading.  The fix is to improve readability and make
>>> static checkers happy.  You're over dramatizing it to make people think
>>> it has a security impact when it doesn't.
>>>
>>> If the user wants to specify v1 data they can just say that on the first
>>> read.  They don't need to do funny tricks and race between the two
>>> reads.  It's allowed.
>>>
>>> In other words this allows the user to do something in a very
>>> complicated way which they are already allowed to do in a very simple
>>> straight forward way.
>>>
>>> regards,
>>> dan carpenter
>>
>> Thanks for your comment, Dan! How about this:
>>
>> However, given that the user data resides in the user space, a
>> malicious user-space process can race to change the data between the
>> two copies. By doing so, the attacker can provide a data with an
>> inconsistent version, e.g., v1 version + v3 data. The current kernel
>> can handle such inconsistent data. But, it may pose a potential
>> security risk for future implementations. Also, to improve code
>> readability and make static analysis tools happy, which will warn
>> about read-verify-re-read type bugs, this issue should be fixed.
>
> There is nothing preventing the user from using struct lov_mds_md_v3 but
> filling in lmm_magic = LOV_MAGIC_V1 from the beginning, no need for a race.
>

But, if the user uses such a struct, the second fetch won't be
executed. This is a little bit different from using LOV_MAGIC_V3
firstly and then changing it to LOV_MAGIC_V1.

Wenwen
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

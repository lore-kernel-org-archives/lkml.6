Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2056830-1525127921-2-10065985618770722730
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525127921; b=EO7Fdw8/bwIKuGNwzdORaDPhAprAcymJxutbZ7jsbFtgu/xXup
    S5GfjFjnnR20cJ3YcI2W/QqZn5oIYM9rNnmJO89yDGn5XVDPL3bGBijtgy+lRnt1
    KQ/WZ3KI8ULmD+xXxqBWnJUehGnZRJc0hSJxjwWebP/KuOoVqAHsFNxqoMZ3MfvM
    TiFgBQ98rTMxWFOIA3ld2U/rHn9Ovnr7LMmAZ6ynBnq3RyNdRw6VKoeW2HEzkty0
    J8Fih4X7D7DTRUHcknZN7Pl7SW6DL/SJPa6oeuhHYRPMA4rU6QhfpkYK8dJXGjq5
    bIyqeIxzYbumULMZ0o8UhpyU4F7s+1GO1Dgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1525127921; bh=2PRVhH6dt9s45g7uHmQlixpFf1ZRtCZ
    PlwoJ+fKqSww=; b=BWxtwee7xVwjtUNpCdS+oaHkpK75Zwc1MA1vVF5YWYeV+eG
    mXhJ6HjoPp6+pjvnjg8Qdt76kByXmjKSpwxM4tpFVCYKQuDRMyqxnf9xlK9O6Uzw
    YEQ9U5/IVJHJQgQd7r05EEY511+PvB9gw5vAUHg9vOmT25DCi7FzisCScfbgUxZh
    TbLSWcTNFb9HT9CsXkkgUqvhD4aVO7Ue7MYdHn60L0M+8UBlX1b/I2H0FAt0+8T1
    wZ96gHIL8sBxwUq4AKMW4R96gnX7nGrPlPBx//++BqVwKPUo2hfQs3f+xWHCXcMD
    sBrAIOKhre6CXmkUt7wfuUP8NpGiBN2xr8gxkOA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPlMWj5isyhxrNHsrFtpNmFgtFQS+WK3hev5oiQlTZkd2pZuBYYaO4TRDoZkVm6MoOq14LWlVSpMqPSsIRvBAlCEegNXVYO0AbQXRwfTIGbpA1VgcNE3
    UJ1cvseXaE/82t9QTXb5bc31hT32dfrC5HXtAxa+W7nThLH+3QU6PiAZ75TUHEGnIicd5/iOxnAnFl5N5c5L9GX6+bHm2T6fqNCPIZt2ecgkRfH3li9lpqaC
    bImZ56BPaJPSXkFL6HEn7w==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=AycjEXJFu3AA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8
    a=DDOyTI_5AAAA:8 a=LG_k5ukMYymHqRa1agYA:9 a=0S8RBEVkCfGGVeYH:21
    a=qP7ECUoFtjMrcgLX:21 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,348,1520924400"; d="scan'208";a="37655642"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: luster: llite: fix a potential missing-check
 bug when copying lumv
Thread-Topic: [PATCH] staging: luster: llite: fix a potential missing-check
 bug when copying lumv
Thread-Index: AQHT3oHTyuO7iDQp7kKGVoSdfIZNdqQWzXsAgAFkrACAAi4cgA==
Date: Mon, 30 Apr 2018 22:38:30 +0000
Message-ID: <69A8B9D9-9330-4750-BAAC-94480A1072D5@intel.com>
References: <1524872704-13391-1-git-send-email-wang6495@umn.edu>
 <8E6ADED8-592E-4794-8CAB-913A325B1971@intel.com>
 <20180429132058.GB5972@kroah.com>
In-Reply-To: <20180429132058.GB5972@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.157]
Content-ID: <1B3EDF9F6BEF61488FF8FDD386B0AAE6@intel.com>
MIME-Version: 1.0
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Aastha Gupta <aastha.gupta4104@gmail.com>, Jeff Layton <jlayton@redhat.com>,
 "Drokin, Oleg" <oleg.drokin@intel.com>, Wenwen Wang <wang6495@umn.edu>,
 "kjlu@umn.edu" <kjlu@umn.edu>, NeilBrown <neilb@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ben Evans <bevans@cray.com>,
 "lustre-devel@lists.lustre.org" <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Apr 29, 2018, at 07:20, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> On Sat, Apr 28, 2018 at 04:04:25PM +0000, Dilger, Andreas wrote:
>> On Apr 27, 2018, at 17:45, Wenwen Wang <wang6495@umn.edu> wrote:
>>> [PATCH] staging: luster: llite: fix potential missing-check bug when copying lumv
>> 
>> (typo) s/luster/lustre/
>> 
>>> In ll_dir_ioctl(), the object lumv3 is firstly copied from the user space
>>> using Its address, i.e., lumv1 = &lumv3. If the lmm_magic field of lumv3 is
>>> LOV_USER_MAGIV_V3, lumv3 will be modified by the second copy from the user
>> 
>> (typo) s/MAGIV/MAGIC/
>> 
>>> space. The second copy is necessary, because the two versions (i.e.,
>>> lov_user_md_v1 and lov_user_md_v3) have different data formats and lengths.
>>> However, given that the user data resides in the user space, a malicious
>>> user-space process can race to change the data between the two copies. By
>>> doing so, the attacker can provide a data with an inconsistent version,
>>> e.g., v1 version + v3 data. This can lead to logical errors in the
>>> following execution in ll_dir_setstripe(), which performs different actions
>>> according to the version specified by the field lmm_magic.
>> 
>> This isn't a serious bug in the end.  The LOV_USER_MAGIC_V3 check just copies
>> a bit more data from userspace (the lmm_pool field).  It would be more of a
>> problem if the reverse was possible (copy smaller V1 buffer, but change the
>> magic to LOV_USER_MAGIC_V3 afterward), but this isn't possible since the second
>> copy is not done if there is a V1 magic.  If the user changes from V3 magic
>> to V1 in a racy manner it means less data will be used than copied, which
>> is harmless.
>> 
>>> This patch rechecks the version field lmm_magic in the second copy.  If the
>>> version is not as expected, i.e., LOV_USER_MAGIC_V3, an error code will be
>>> returned: -EINVAL.
>> 
>> This isn't a bad idea in any case, since it verifies the data copied from
>> userspace is still valid.
> 
> So you agree with this patch?  Or do not?
> 
> confused,

I don't think it fixes a real bug, but it makes the code a bit more clear,
so I'm OK to land it (with minor corrections to commit message per above).

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation







_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

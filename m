Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2125232-1524931476-2-10760338991752263535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524931475; b=MhhSNtMXXFDV354gLKhuQNGqbQ1J+qquDAdzZfLrkAoOmL8TOx
    nN32iudpbEd2XGq6xU0pKmqQ+DZqcWtIZ20D3nDd8iID9frBzRjbkgce67u7J7S+
    ga5BZxQNPrPsXjcG2QYs1u99ukd424NHIo4qpjrzJLDz+XhbEVPbMS64wBMnPLkf
    MlqmA+3uxxXOR8fgqdB5Ob+agUyx8dDhlCyd0G2BacqgXlt87+x6CKVJTBo3wv1G
    jFm+eGZAIbAsLbSpPHZUEnx7ZGERFy2xNNl+k2TkaEqVTrTyJGAtrAPzpoJ1x3aM
    iHbcxi2wL7nFq21/eY9Xdznro2mCQWAhzjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1524931475; bh=7L0zef+t1FSm3s7eMek88A2ANnTIEHD
    ntz6zmHVIbtY=; b=W6p+tH7pkjtcFo2Zwhk8HmhxuG0xKwQSxSSUoSg5uyZg6WK
    BAs9s/fQiAG0vOypSAz0pxWkgsJ9njw/BL7BKxvYnNrs9oWM/LSgQfDzgWySXBb4
    fNNS5Y3EPik/chGlhoggwMFVNS7NcdsgKJoCFLdsz2tutWm1PNl+EzEg3EBchWKB
    1NmX+xdYxOl/LkW1hP3p2whChVLgr2OZhFqhZ+kD/uAGRfC0YbRX6PuEn8NFy/GH
    d+yvgW2rPEMhqNhFr9eYoBfguvzGZn9iDbTOpezas+NCzCahRtBkzbwLap+tFm1m
    Df0jHPrRVd9yk6CnTojwfnIwosDk2+ouUOLw4fg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHrDfWglJfH5qUaVy7cPoo0su+aUqhUTEwMvDvB5olSN/pl9LddKAtPVJq3zyZueogYfhk3PjFGSEktJbW05n1ViO81tveFAQIwhFtjT2oxT9jQg8B35
    Bx6vMYOYHpqIHNeZdB2fn7S+P83TYR2VOiVat2fiS4uo+JaAZ4ooWPaNbQYV6E3TzRBDhkxivFpcmXsB1ppEiDLp5cJ5tOCpVFPZrBdIVubdrxtIwHPMlYKL
    rSn6DG5crWfF+HVSvvo44Q==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=f080-uOVnbkA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=V8LWtCLsv3H9hRq5sU0A:9 a=ykxLZmptvbfcU0np:21 a=D3iuaZx6F7DPUNah:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,339,1520924400"; d="scan'208";a="37172456"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH] staging: luster: llite: fix a potential missing-check
 bug when copying lumv
Thread-Topic: [PATCH] staging: luster: llite: fix a potential missing-check
 bug when copying lumv
Thread-Index: AQHT3oHTyuO7iDQp7kKGVoSdfIZNdqQWzXsA
Date: Sat, 28 Apr 2018 16:04:25 +0000
Message-ID: <8E6ADED8-592E-4794-8CAB-913A325B1971@intel.com>
References: <1524872704-13391-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1524872704-13391-1-git-send-email-wang6495@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.131.45]
Content-ID: <61F80F78FCC96D46A01C694E3A7C6E13@intel.com>
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
 Ben Evans <bevans@cray.com>, Jeff Layton <jlayton@redhat.com>,
 Aastha Gupta <aastha.gupta4104@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "kjlu@umn.edu" <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>,
 "lustre-devel@lists.lustre.org" <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Apr 27, 2018, at 17:45, Wenwen Wang <wang6495@umn.edu> wrote:
> [PATCH] staging: luster: llite: fix potential missing-check bug when copying lumv

(typo) s/luster/lustre/

> In ll_dir_ioctl(), the object lumv3 is firstly copied from the user space
> using Its address, i.e., lumv1 = &lumv3. If the lmm_magic field of lumv3 is
> LOV_USER_MAGIV_V3, lumv3 will be modified by the second copy from the user

(typo) s/MAGIV/MAGIC/

> space. The second copy is necessary, because the two versions (i.e.,
> lov_user_md_v1 and lov_user_md_v3) have different data formats and lengths.
> However, given that the user data resides in the user space, a malicious
> user-space process can race to change the data between the two copies. By
> doing so, the attacker can provide a data with an inconsistent version,
> e.g., v1 version + v3 data. This can lead to logical errors in the
> following execution in ll_dir_setstripe(), which performs different actions
> according to the version specified by the field lmm_magic.

This isn't a serious bug in the end.  The LOV_USER_MAGIC_V3 check just copies
a bit more data from userspace (the lmm_pool field).  It would be more of a
problem if the reverse was possible (copy smaller V1 buffer, but change the
magic to LOV_USER_MAGIC_V3 afterward), but this isn't possible since the second
copy is not done if there is a V1 magic.  If the user changes from V3 magic
to V1 in a racy manner it means less data will be used than copied, which
is harmless.

> This patch rechecks the version field lmm_magic in the second copy.  If the
> version is not as expected, i.e., LOV_USER_MAGIC_V3, an error code will be
> returned: -EINVAL.

This isn't a bad idea in any case, since it verifies the data copied from
userspace is still valid.

Cheers, Andreas

> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
> drivers/staging/lustre/lustre/llite/dir.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/lustre/lustre/llite/dir.c b/drivers/staging/lustre/lustre/llite/dir.c
> index d10d272..80d44ca 100644
> --- a/drivers/staging/lustre/lustre/llite/dir.c
> +++ b/drivers/staging/lustre/lustre/llite/dir.c
> @@ -1185,6 +1185,8 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> 		if (lumv1->lmm_magic == LOV_USER_MAGIC_V3) {
> 			if (copy_from_user(&lumv3, lumv3p, sizeof(lumv3)))
> 				return -EFAULT;
> +			if (lumv3.lmm_magic != LOV_USER_MAGIC_V3)
> +				return -EINVAL;
> 		}
> 
> 		if (is_root_inode(inode))
> -- 
> 2.7.4
> 

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation







_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

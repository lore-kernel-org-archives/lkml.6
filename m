Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2437530-1525147627-2-10186552220879275276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525147626; b=TNuj2vYRQHSqGQcROspt2Ui6LHO63N+MGCMXOFtnkPlU+F69gv
    TujGo/GraBpDoTScXtEZQoGYnUtmSK6NZVe/h9i/m26J47wkNfg46u3bYfZTq3k2
    KhpMT3mJbWU6SY3RcBKmz6CvqmSOj3S8uqGBFpKypMZWYltFaGnLjrppX34KaUrR
    PZpcypMjyAnZX+DF8ByROr4LWzRaWn9o+UsZSeEIm8brl0ce0/IqBtBByNzkeotD
    HkHSQdd3k+p/ZSRXHIWM9jPceMxJM6oPANfRL+M0Ry8yfWco1i2YEMrHrcEOmB1A
    CJJWDC6URy1AZ0BlboGNqYeuVhJUadc3+qNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1525147626; bh=BXe8cNU8litXrdIQheZvNg85O7fCKcb
    VARvEHfuWKrc=; b=fZFwAweb7SCy5eTfxS7BdOQSOmyqzkof6z9D79xCbj3u7rq
    agSxOWxohPLlyvTPjgVMpKX+ZvSuuRI+UJBkAXNK1q6abPlHt8HAtOIqLa4amdNO
    p4Ycp10sGn0gNbbRky+EsI9ysq7PY66rLkUKTvzmQ8FzXc5jetuEiI3QGPflG654
    7jMVtrJq5x6aFmTUWTtFgvmLE3Yt03Hgy4tcR8JMc/hux6Bc83LYj0o36tsoS4TO
    2Pf1JhQroZpU1qIHS136PbOn1o5tKmlNZ3fhysrKxGS64vt110654GCIGD8leG3Q
    2YNnQNQCn+8MYWM5HTEtIO5jtupg6r4uczKY12Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAbxDvJKRixxtfi+/jUf3vQCTNHC6doYYZeTqjRS21B1HhNlAx1VuUEwh/W4kw+Nleiwy/dz1PHYJX9U5JnzCJ7UQxhGy8Uzv+5baus/CMBxZwOuH91f
    GLSoK+XFfkUVbkimvuJXPjnT62+28Pl0rbavQSz9eFG1sJhpcUL0RkAkmnhFycN168+nQ+KJHI7jK7zXuObjbQOQu8F9wNn6E5TQKtD9np3vhfw+X1ifsNNV
    /n0CnxGm0oRDxuXnBQe0Iw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=AycjEXJFu3AA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8
    a=DDOyTI_5AAAA:8 a=V8LWtCLsv3H9hRq5sU0A:9 a=3eAYwqZii-nBWJql:21
    a=r5XXeeRLJyhvVf7f:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,349,1520924400"; d="scan'208";a="37444768"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
Thread-Topic: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
Thread-Index: AQHT4NZ/GvK7CQDrfEibHz/EWOxvVaQat1qA
Date: Tue, 1 May 2018 04:06:56 +0000
Message-ID: <BA97D240-2B0A-4AD4-B83B-201C285E4DEB@intel.com>
References: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.157]
Content-ID: <9C44E211C32C8846B8454FF0FA5249FC@intel.com>
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Aastha Gupta <aastha.gupta4104@gmail.com>,
 Roman Storozhenko <romeusmeister@gmail.com>, Jeff Layton <jlayton@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kangjie Lu <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>, open list <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>,
 "moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
 <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Apr 30, 2018, at 16:56, Wenwen Wang <wang6495@umn.edu> wrote:
> 
> In ll_dir_ioctl(), the object lumv3 is firstly copied from the user space
> using Its address, i.e., lumv1 = &lumv3. If the lmm_magic field of lumv3 is
> LOV_USER_MAGIC_V3, lumv3 will be modified by the second copy from the user
> space. The second copy is necessary, because the two versions (i.e.,
> lov_user_md_v1 and lov_user_md_v3) have different data formats and lengths.
> However, given that the user data resides in the user space, a malicious
> user-space process can race to change the data between the two copies. By
> doing so, the attacker can provide a data with an inconsistent version,
> e.g., v1 version + v3 data. This can lead to logical errors in the
> following execution in ll_dir_setstripe(), which performs different actions
> according to the version specified by the field lmm_magic.
> 
> This patch rechecks the version field lmm_magic in the second copy.  If the
> version is not as expected, i.e., LOV_USER_MAGIC_V3, an error code will be
> returned: -EINVAL.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Thanks for the updated patch.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

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

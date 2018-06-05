Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeFEPrx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:47:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57874 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeFEPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:47:51 -0400
Subject: Re: [PATCH] Use an IDR to allocate apparmor secids
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org
References: <20180522093259.GA30182@bombadil.infradead.org>
 <20180528170108.GA5448@bombadil.infradead.org>
 <862d03b6-ba2f-3ec0-d45e-d8fcf16f9edf@canonical.com>
 <20180605022712.GB32444@bombadil.infradead.org>
 <4e075d0a-2e4d-f298-070c-836324864b97@canonical.com>
 <20180605114734.GA20472@bombadil.infradead.org>
From: John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <375d2b5c-0643-b257-c9c9-6f1fdc3ac53b@canonical.com>
Date: Tue, 5 Jun 2018 08:47:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605114734.GA20472@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 04:47 AM, Matthew Wilcox wrote:
> On Mon, Jun 04, 2018 at 07:35:24PM -0700, John Johansen wrote:
>> On 06/04/2018 07:27 PM, Matthew Wilcox wrote:
>>> On Mon, Jun 04, 2018 at 06:27:09PM -0700, John Johansen wrote:
>>>> hey Mathew,
>>>>
>>>> I've pulled this into apparmor-next and done the retuning of
>>>> AA_SECID_INVALID a follow on patch. The reworking of the api to
>>>> return the specific error type can wait for another cycle.
>>>
>>> Oh ... here's what I currently have.  I decided that AA_SECID_INVALID
>>> wasn't needed.
>>>
>> well not needed in the allocation path, but definitely needed and it
>> needs to be 0.
>>
>> This is for catching some uninitialized or freed and zeroed values.
>> The debug checks aren't in the current version, as they were
>> residing in another debug patch, but I will pull them out into their
>> own patch.
> 
> With the IDR, I don't know if you need it for debug.
> 
> 	BUG_ON(label != idr_find(&aa_secids, label->secid))
> 
> should do the trick.
> 

its not so much the idr as the network and audit structs where the
secid gets used and then security system is asked to convert from
the secid to the secctx.

We need an invalid secid for when conversion result in an error,
partly because the returned error is ignored in some paths (eg. scm)
so we also make sure to have an invalid value.

Having it be zero helps us catch bugs on structs that are zero
but we miss initializing, and also works well with apparmor always
zeroing structs on free.

The debug patch didn't get included yet because the networking
code that make use of the secids hasn't landed yet (they are being
used in the audit path) so the debug patch ends up throwing a
lot of warning for the networking paths.

The patch I am testing on top of your patch is below

---

commit d5de3b1d21687c16df0a75b6309ab8481629a841
Author: John Johansen <john.johansen@canonical.com>
Date:   Mon Jun 4 19:44:59 2018 -0700

    apparmor: cleanup secid map convertion to using idr
    
    The idr convertion didn't handle an error case for when allocating a
    mapping fails.
    
    In addition it did not ensure that mappings did not allocate or use a
    0 value, which is used as an invalid secid because it allows debug
    code to detect when objects have not been correctly initialized or
    freed too early.
    
    Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 686de8e50a79..dee6fa3b6081 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -28,8 +28,10 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
 
-u32 aa_alloc_secid(struct aa_label *label, gfp_t gfp);
+int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
 void aa_free_secid(u32 secid);
 void aa_secid_update(u32 secid, struct aa_label *label);
 
+void aa_secids_init(void);
+
 #endif /* __AA_SECID_H */
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index a17574df611b..ba11bdf9043a 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -407,8 +407,7 @@ bool aa_label_init(struct aa_label *label, int size, gfp_t gfp)
 	AA_BUG(!label);
 	AA_BUG(size < 1);
 
-	label->secid = aa_alloc_secid(label, gfp);
-	if (label->secid == AA_SECID_INVALID)
+	if (aa_alloc_secid(label, gfp) < 0)
 		return false;
 
 	label->size = size;			/* doesn't include null */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index dab5409f2608..9ae7f9339513 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1546,6 +1546,8 @@ static int __init apparmor_init(void)
 		return 0;
 	}
 
+	aa_secids_init();
+
 	error = aa_setup_dfa_engine();
 	if (error) {
 		AA_ERROR("Unable to setup dfa engine\n");
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 3ad94b2ffbb2..ad6221e1f25f 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -33,6 +33,8 @@
  * properly updating/freeing them
  */
 
+#define AA_FIRST_SECID 1
+
 static DEFINE_IDR(aa_secids);
 static DEFINE_SPINLOCK(secid_lock);
 
@@ -120,20 +122,30 @@ void apparmor_release_secctx(char *secdata, u32 seclen)
 
 /**
  * aa_alloc_secid - allocate a new secid for a profile
+ * @label: the label to allocate a secid for
+ * @gfp: memory allocation flags
+ *
+ * Returns: 0 with @label->secid initialized
+ *          <0 returns error with @label->secid set to AA_SECID_INVALID
  */
-u32 aa_alloc_secid(struct aa_label *label, gfp_t gfp)
+int aa_alloc_secid(struct aa_label *label, gfp_t gfp)
 {
 	unsigned long flags;
-	u32 secid;
+	int ret;
 
 	idr_preload(gfp);
 	spin_lock_irqsave(&secid_lock, flags);
-	secid = idr_alloc(&aa_secids, label, 0, 0, GFP_ATOMIC);
-	/* XXX: Can return -ENOMEM */
+	ret = idr_alloc(&aa_secids, label, 1, 0, GFP_ATOMIC);
 	spin_unlock_irqrestore(&secid_lock, flags);
 	idr_preload_end();
 
-	return secid;
+	if (ret < 0) {
+		label->secid = AA_SECID_INVALID;
+		return ret;
+	}
+
+	label->secid = ret;
+	return 0;
 }
 
 /**
@@ -148,3 +160,8 @@ void aa_free_secid(u32 secid)
 	idr_remove(&aa_secids, secid);
 	spin_unlock_irqrestore(&secid_lock, flags);
 }
+
+void aa_secids_init(void)
+{
+	idr_init_base(&aa_secids, AA_FIRST_SECID);
+}

Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3277975-1517743486-2-14792321360321154954
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517743486; b=tPcaBOXIdOQBGFvPX6Ccqz/T+6NItAzcl0i06Tn08Wkfumu
    9PK/pS0o2+3wVg2hG82vxz1Py0iE/CgpNPOXZ+XnfvL5ZR6VHa7x6HAV1Ci9rp9X
    kkp08YvRTAy3H6LhhnkegS0PaG2qVn2cI73PjiEKRQToTIK4cq1ids11UclUz60G
    zYN7rzvcnIrRUNsw7Z3T9qNsRYLCC+lPUKacJzfsvYE/mqFN99oJTz0qwGzr5jzh
    2t1cqofpLlujNEqng3JH4izzrHCSe8unvzPEqLH8EngKPnqVABJ0QNpzxkhTvBCc
    k7NZZor737kWYlR6ffuYcime+1x/z/43L+OVD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517743486; bh=q
    4klqUsZWII8lvtkZaRx+BbL9i+zKHr0EmJ2vEOy4P0=; b=tsQ9EF+pDDvMVal1g
    Q0j+klfFcvjmF28vNa8ayiYmErE2oa/hxkGe4tZlcQYv49maJe3yehcxKWAFV1vU
    T3VAJF9yS+7E21+yWMZWbmW+r4yQgbyEenKtewUfVLROpAFe9zlE1A5lE5eszYK3
    KJhHbsCHhfeLCTTWiMRXufm2x5bMhAaOuujleWxXQWi/I1OBR/gTFncd8WVMwfJ7
    pI/L0D16hQDTMKkVaZeCFEqzU+1ohborDoxVEBsgMKhwDwrTVA2lxSZW29SDnhgu
    4nIDbDPEBZCuI2bQfqqTY62Y91fH2edybxHQriWTTuf2MnrDlHPekMhYo83AOwBe
    0WAow==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH] staging: lustre: llite: replace variable length array
To: "Dilger, Andreas" <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
References: <20180127214228.26986-1-sven.dziadek@gmx.de>
 <D887F611-EA3C-45CD-BEBC-3BA994048B59@intel.com>
From: Sven Dziadek <sven.dziadek@gmx.de>
Message-ID: <58963c7f-139c-1156-0179-13decf0bcddf@gmx.de>
Date: Sun, 4 Feb 2018 12:24:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <D887F611-EA3C-45CD-BEBC-3BA994048B59@intel.com>
Content-Language: en-US
X-Provags-ID: V03:K0:SnASyH58fo+TchvXOPqbFreqJ9wxIEFaZQ/qW6HWv0UEwZI42ew
 1PhE2s33b/PUE2e7C5/4pewFRDSvfeQlLC0s5x3ZrY4dyY9cj+71spkxyJ4tpYIevRC4u9g
 NFV3xGr9twLjKCddm+mWsWNZSckosYyDLVMfNWL9eDXHlYkf7E7GR1mae98xhhzsloO6nDF
 +pkkdnHRoq+Amd+zkmHbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:55rM2CIx/7Y=:bQgnZhUdLH0qEem1qmhMM5
 3fbPiB/agh9bJkLOe4a0ChWa5ysXF1ORKDQ4t6sJyKMmzfb1rNuIE1HnaBcts2re53C8cX1qz
 Gz0xRHALTE0Hu7AgvHF2ZNSPEVltlBI9mGpBSSKBo/Ke9t5fg9zPqz5tKNAByJboTyyXhz44o
 wTeAqwKJ4GR5/EQdjhiwkc0ZsfC5KdlSYZpmJRW61E5AW1jm9JCoKjxuh+NPggHrKMD+M2pEv
 bcyWJ2N+yoaDpVF0zPKwBmCy5YbFMkvR/KwEFMAQeQRNE8nmnuwxse+OqZ/HWS6uhuX6wLW/3
 JVd8mG53sSmj5YZ9QOhfvkBjvLlt6gL964eXfpyz1kTOmrDo4QyHGucNqNHUCXwm0NC6h7P4Z
 yxghYG1tgMYSTZ6z9WD/IJVK3kUS12ngrdFvIfz3cZ8+z79jH8BZ9eSfBvO9WHM24VYgPsGSf
 rpUh3Hnlf8HMoCSsgm4EUm9PAhWWbII2lEqolHBrdQn9tZc4wLACGZH1LdtPe6KnZk8vFOczN
 zItSrV5Eu8px6pYwR6DroiCa+sp0ls/HeMJdJd6lvi1jia3MYopHl8BxPIa7fDgg77gRLhbcu
 xuNnR/ob6VwuXOq+AQUnJ8pPPEHg0tW8EghQpEqo2sACLLpSf73TvwwWggzu7cxDXUKsmeWO1
 ANrZTc6pHnMsBQCWeuSLL6ydxi0b9RBH0uoo7V2YfcFjNff0cs870wDcvrXOgcHFDSTMknlqS
 4mKOeROfRk4blU0cz9H8SM8XztvMBZoDqDZEI1pAkOT1BQpSqbRgwzIBwiY4T2IdmWYI/dfRu
 ijTLhm+AwIRTL+SwqoiC8kDb1+dRrB8Tc7rI53xcvFVzG5iLlQ=
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Eremin,
 Dmitry" <dmitry.eremin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, "Drokin, Oleg" <oleg.drokin@intel.com>,
 lustre-devel <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/30/2018 03:04 AM, Dilger, Andreas wrote:
> On Jan 27, 2018, at 14:42, Sven Dziadek <sven.dziadek@gmx.de> wrote:
>>
>> The functionality of the removed variable length array is already
>> implemented by the function xattr_full_name in fs/xattr.c
>>
>> This fixes the sparse warning:
>> warning: Variable length array is used.
>>
>> Signed-off-by: Sven Dziadek <sven.dziadek@gmx.de>
>> ---
>> drivers/staging/lustre/lustre/llite/xattr.c | 12 ++++--------
>> 1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
>> index 532384c91447..4fd28213c6a1 100644
>> --- a/drivers/staging/lustre/lustre/llite/xattr.c
>> +++ b/drivers/staging/lustre/lustre/llite/xattr.c
>> @@ -87,7 +87,6 @@ ll_xattr_set_common(const struct xattr_handler *handler,
>> 		    const char *name, const void *value, size_t size,
>> 		    int flags)
>> {
>> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
>> 	struct ll_sb_info *sbi = ll_i2sbi(inode);
>> 	struct ptlrpc_request *req = NULL;
>> 	const char *pv = value;
>> @@ -141,9 +140,8 @@ ll_xattr_set_common(const struct xattr_handler *handler,
>> 			return -EPERM;
>> 	}
>>
>> -	sprintf(fullname, "%s%s\n", handler->prefix, name);
>> -	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
>> -			 valid, fullname, pv, size, 0, flags,
>> +	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode), valid,
>> +			 xattr_full_name(handler, name), pv, size, 0, flags,
>> 			 ll_i2suppgid(inode), &req);
> 
> Hi Sven,
> thanks for the patch.
> 
> Looking at the details of "xattr_full_name()", this seems quite risky.  This
> is essentially returning the pointer _before_ "name" on the assumption that
> it contains the full "prefix.name" string.  IMHO, that is not necessarily a
> safe assumption to make several layers down in the code.
Thanks for your reply. And yeah, it feels strange, right.

But it really looks like this is how the name and the prefix is handled
in the xattr code.
It seems this helper function has been introduced with commit
e409de992e3ea (which also removes some fullname pointer) and indeed,
fs/xattr.c splits the prefix and the name in xattr_resolve_name.

So I still think the patch should be correct..?

> James, I thought you had a patch for this to use kasprintf() instead of the
> on-stack "fullname" declaration?
Sorry for replying that late, I though James would maybe know if the
above assumption is correct..

>> 	if (rc) {
>> 		if (rc == -EOPNOTSUPP && handler->flags == XATTR_USER_T) {
>> @@ -364,7 +362,6 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
>> 			       struct dentry *dentry, struct inode *inode,
>> 			       const char *name, void *buffer, size_t size)
>> {
>> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
>> 	struct ll_sb_info *sbi = ll_i2sbi(inode);
>> #ifdef CONFIG_FS_POSIX_ACL
>> 	struct ll_inode_info *lli = ll_i2info(inode);
>> @@ -411,9 +408,8 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
>> 	if (handler->flags == XATTR_ACL_DEFAULT_T && !S_ISDIR(inode->i_mode))
>> 		return -ENODATA;
>> #endif
>> -	sprintf(fullname, "%s%s\n", handler->prefix, name);
>> -	return ll_xattr_list(inode, fullname, handler->flags, buffer, size,
>> -			     OBD_MD_FLXATTR);
>> +	return ll_xattr_list(inode, xattr_full_name(handler, name),
>> +			     handler->flags, buffer, size, OBD_MD_FLXATTR);
>> }
>>
>> static ssize_t ll_getxattr_lov(struct inode *inode, void *buf, size_t buf_size)
>> -- 
>> 2.11.0
>>

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3808880-1520443242-5-14309663968522559776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520443242; b=geiSfkAd2ofiK6evzjHu6xRbAVZnZxM2bZugTYmv7MI8ofi
    b0g30CDqju88g8q3SqI/gQwdT1XjDeb+XK/brpRTODxaSELzOd8oMjMcXotyxX82
    7kolN/OTNGDj241GJmaZFNuVPiuVBRFJ8AdJKMlTgsURQCF6GzgUp4VXjZjENxWl
    TZkAcbqR5RbnZN9EbdVTIHc1XyAKjf+LqkVDJmtoTrrLnZP+vl6JqobVanZ55mnH
    ysW+JAcI3PLq1O9/+hKop3a1yzNEgq/x9WXdmuYdA/wcXwwPQlPeKcpWw+Z2h+sX
    ZzQyNTW+3OnqrORtuqUyJlTOgtjmK4tp+SperyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520443242; bh=l
    U+Kfr2vRkWQ8auiAnACW2i7bWnTBMvOmGkw+92ZJdI=; b=M1HFLz2uxTxu69WzU
    gQK2mAzD0tt4tdZR4BrDWOzQFV0cmc+qwPWFRhpCDLO/NjcLRz+MR2SymAcJp1Fo
    n9u+B4XUEPsKLPV6TElazul6B0RZooK7WqlyyqHU6D+7UMdMWR6uqbacmhSv948u
    GJxXjMnbqMU3PL3ZkZ8ZDxgFuOtA4Jrfsj9FELpVyOc2IWC5pHeMBk8EUSMWaEBA
    8gKChZGNqaIV5QvnW3dpjrwxxdAXG2fdkDS7uYONbgReo8OYwLYmrtqpUxExs5vt
    nnShT3th2f+VUQ1wUP85Il8pQqxCYFa39sIdN7MtivS/V1ECq7iUn6dj+BtPdJ4H
    i6CSw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=esDeVges x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=XmGK4pQ4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TS5FNHOV;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=esDeVges x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=XmGK4pQ4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TS5FNHOV;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuch/3WOpmrgdRWAgGq8kljYq9JW8cKIgYes/UdPsD2mNo81j5fQRB2slrNM9TN1a63HHKqt3cPoJ1z6y0PzJI=
MIME-Version: 1.0
In-Reply-To: <d5de0034-6f74-5b73-2df8-dbe5b366c2fc@prevas.dk>
References: <20180307054608.GA9300@beast>
 <d5de0034-6f74-5b73-2df8-dbe5b366c2fc@prevas.dk>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Mar 2018 09:20:31 -0800
X-Google-Sender-Auth: d1LCYAsV7ZqQx-5-nsStnbT0xj4
Message-ID: <CAGXu5j+OTu84ohuR3f4_xKRw9vikVi-K2TnH3+n_ekX1m1Vv8A@mail.gmail.com>
Subject: Re: [PATCH] staging: lustre: Remove VLA usage
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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
Cc: devel@driverdev.osuosl.org, Dmitry Eremin <dmitry.eremin@intel.com>,
 Tycho Andersen <tycho@tycho.ws>, Andreas Dilger <andreas.dilger@intel.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Gargi Sharma <gs051095@gmail.com>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 5:10 AM, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
> On 2018-03-07 06:46, Kees Cook wrote:
>> The kernel would like to remove all VLA usage. This switches to a
>> simple kasprintf() instead.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/staging/lustre/lustre/llite/xattr.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
>> index 532384c91447..aab4eab64289 100644
>> --- a/drivers/staging/lustre/lustre/llite/xattr.c
>> +++ b/drivers/staging/lustre/lustre/llite/xattr.c
>> @@ -87,7 +87,7 @@ ll_xattr_set_common(const struct xattr_handler *handler,
>>                   const char *name, const void *value, size_t size,
>>                   int flags)
>>  {
>> -     char fullname[strlen(handler->prefix) + strlen(name) + 1];
>> +     char *fullname;
>>       struct ll_sb_info *sbi = ll_i2sbi(inode);
>>       struct ptlrpc_request *req = NULL;
>>       const char *pv = value;
>> @@ -141,10 +141,13 @@ ll_xattr_set_common(const struct xattr_handler *handler,
>>                       return -EPERM;
>>       }
>>
>> -     sprintf(fullname, "%s%s\n", handler->prefix, name);
>
> It's probably worth pointing out that this actually fixes an
> unconditional buffer overflow: fullname only has room for the two
> strings and the '\n', but vsnprintf() is told that the buffer has
> infinite size (well, INT_MAX), so there should be plenty of room to
> append the '\0' after the '\n'.
>
>> +     fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
>> +     if (!fullname)
>> +             return -ENOMEM;
>>       rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
>>                        valid, fullname, pv, size, 0, flags,
>>                        ll_i2suppgid(inode), &req);
>> +     kfree(fullname);
>>       if (rc) {
>>               if (rc == -EOPNOTSUPP && handler->flags == XATTR_USER_T) {
>>                       LCONSOLE_INFO("Disabling user_xattr feature because it is not supported on the server\n");
>> @@ -364,7 +367,7 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
>>                              struct dentry *dentry, struct inode *inode,
>>                              const char *name, void *buffer, size_t size)
>>  {
>> -     char fullname[strlen(handler->prefix) + strlen(name) + 1];
>> +     char *fullname;
>>       struct ll_sb_info *sbi = ll_i2sbi(inode);
>>  #ifdef CONFIG_FS_POSIX_ACL
>>       struct ll_inode_info *lli = ll_i2info(inode);
>> @@ -411,9 +414,13 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
>>       if (handler->flags == XATTR_ACL_DEFAULT_T && !S_ISDIR(inode->i_mode))
>>               return -ENODATA;
>>  #endif
>> -     sprintf(fullname, "%s%s\n", handler->prefix, name);
>
> Same here.
>
> I'm a little surprised this hasn't been caugt by static analysis, I
> thought gcc/coverity/smatch/whatnot had gotten pretty good at computing
> the size of the output generated by a given format string with "known"
> arguments and comparing to the size of the output buffer. Though of
> course it does require the tool to be able to do symbolic manipulations,
> in this case realizing that
>
> outsize == strlen(x)+strlen(y)+1+1 > bufsize == strlen(x)+strlen(y)+1
>
> Rasmus

Oh yes, hah. I didn't even see the \n in the string. :P

So, both a VLA fix and a buffer over-run fix. Can I add your "Reviewed-by"? :)

-Kees

-- 
Kees Cook
Pixel Security
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

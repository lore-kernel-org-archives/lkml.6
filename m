Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67027C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D97C2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D97C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJICTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:19:31 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJICTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:19:30 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MvbOA-1fsTfY02Rq-00siMl; Mon, 08 Oct 2018 21:05:38 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MvbOA-1fsTfY02Rq-00siMl; Mon, 08 Oct 2018 21:05:38 +0200
Subject: Re: [RFC v4 1/1] ns: add binfmt_misc to the user namespace
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>, dima@arista.com,
        containers@lists.linux-foundation.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20181006193546.29340-1-laurent@vivier.eu>
 <20181006193546.29340-2-laurent@vivier.eu>
 <CAG48ez1S7CVDCCec5F-N32BVEPckLb0Qy+PypThezwKA=8HSSg@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6150310e-75fa-0199-71bd-5794392b73c2@vivier.eu>
Date:   Mon, 8 Oct 2018 21:05:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1S7CVDCCec5F-N32BVEPckLb0Qy+PypThezwKA=8HSSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:51xKHDnIkVOnynO02KuJQrPRzc4bdRlsAv0s5BTcioHI8BYvimj
 4tsKWjT7g4Sdbor2PJv5PM1XkLwN8V5pR2SWlwkzLDoKs4fbTnx9Tc0TImO52LTkClZD6jW
 JyOanI5kL2grxZhhlZ25JOVcO1fb/XHRvcjUJsjKjkBuyoUlJkh755/B9CHw0rDRpQKYB03
 IhMzAIgjfVdo/VEdeX8ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ly+IRd+wtnA=:a48I7zdKUYBPUaKCgJfC9Q
 shubyN9ykP7FIBrVBGK8k7lAW7SJ/I15spVFbq68xfJf+wYLaIR6OFYyzv15/Hv8NpefGAbiD
 HkPHPG2gCJgVJEtchnKNEnlbknf15Wuv9n4MeTQetdwtTJIeM7JF0hHX67MOuVJDMMmFR00YX
 BLIvStQtuH+tKGC6QkUYQISCUw87EI5VYYz//WpGksORILQM1hItC3X8W+cgEdMPqHJvNSrow
 9NwDGJSLrugWWD3sCBmbZka7Ni1vI65EoRfWhcmu2e4ecYxgdGU2lXY7gWq5zx9L79CO8CwIu
 4TAtzy41Ogq6U7vGwFYWzQwHwwclwmsXvHxka0Ed4+qXeW+tnGK7gFwzMe7CJsBkd5XfI+8L6
 FDTxL3xuayplHkD20kO6v1wP1Xg3gVaRRONCKIV7edDMcnsByQFad7gAjyTSaEsYu2ZGgjHvj
 4qOz+k5MiZVsXYusL/S2PNm/xVqNJ7GHyPwaSsyn3uctndFkmfMMp6jT3AruL3+kKsLx1erpX
 DF+bw5DyH2DO8CraO9knp4q20A1qcoI+DmwNR7DZw8AaRKLpkV1uq5S8Tf76KxfBbo2DiIp40
 dmddo2+vAtDnckxawwvk7sB0l3OnQzDrRS4rXx3d0ecBEX7sVdPcIXtATORCuXW68579qFHZm
 JQXw2EPtrZz/XgrAzsEtKa+CUA8P+M3HK2281L9TidDTNkVFhwyImts8MxUGqP4U/QNIlGLU6
 kABz8VYyV8PENEzs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/10/2018 à 13:26, Jann Horn a écrit :
> On Sat, Oct 6, 2018 at 9:36 PM Laurent Vivier <laurent@vivier.eu> wrote:
>> This patch allows to have a different binfmt_misc configuration
>> for each new user namespace. By default, the binfmt_misc configuration
>> is the one of the previous level, but if the binfmt_misc filesystem is
>> mounted in the new namespace a new empty binfmt instance is created and
>> used in this namespace.
>>
>> For instance, using "unshare" we can start a chroot of an another
>> architecture and configure the binfmt_misc interpreter without being root
>> to run the binaries in this chroot.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
> [...]
...
>> @@ -838,7 +858,29 @@ static int bm_fill_super(struct super_block *sb, void *data, int silent)
>>  static struct dentry *bm_mount(struct file_system_type *fs_type,
>>         int flags, const char *dev_name, void *data)
>>  {
>> -       return mount_single(fs_type, flags, data, bm_fill_super);
>> +       struct user_namespace *ns = current_user_ns();
>> +
>> +       /* create a new binfmt namespace
>> +        * if we are not in the first user namespace
>> +        * but the binfmt namespace is the first one
>> +        */
>> +       if (ns->binfmt_ns == NULL) {
>> +               struct binfmt_namespace *new_ns;
>> +
>> +               new_ns = kmalloc(sizeof(struct binfmt_namespace),
>> +                                GFP_KERNEL);
>> +               if (new_ns == NULL)
>> +                       return ERR_PTR(-ENOMEM);
>> +               INIT_LIST_HEAD(&new_ns->entries);
>> +               new_ns->enabled = 1;
>> +               rwlock_init(&new_ns->entries_lock);
>> +               new_ns->bm_mnt = NULL;
>> +               new_ns->entry_count = 0;
>> +               ns->binfmt_ns = new_ns;
> 
> What happens if someone mounts two instances of the binfmt_misc
> filesystem at the same time? Would you end up creating two binfmt
> namespaces, one of which would never be freed again?

I think you're right. And there is also a problem if mount_ns() fails.

So I think I can put this sequence in bm_fill_super() to avoid these
problems.

Thanks,
Laurent

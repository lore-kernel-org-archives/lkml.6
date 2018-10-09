Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55CFC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9288E213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9288E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeJIUXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:23:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIUXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:23:53 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MiMIY-1fVagf3G1m-00fSlg; Tue, 09 Oct 2018 15:06:19 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MiMIY-1fVagf3G1m-00fSlg; Tue, 09 Oct 2018 15:06:19 +0200
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, dima@arista.com,
        Linux API <linux-api@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, avagin@gmail.com,
        containers@lists.linux-foundation.org
References: <20181009103752.21482-1-laurent@vivier.eu>
 <20181009103752.21482-2-laurent@vivier.eu>
 <CAG48ez1OVKqRZe6AtTwXSc27AjNF596nt-46J9WPffKu7fNb8Q@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <9059ed5a-6a0d-7f4d-7854-48b3ae4cca76@vivier.eu>
Date:   Tue, 9 Oct 2018 15:06:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1OVKqRZe6AtTwXSc27AjNF596nt-46J9WPffKu7fNb8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e513gMT+K9czCkREBQWRiwctyhTGb9JxIVM7/KWXFkXFVod0NmW
 3cGrEI5Ad18J4ilVT/73NHeOHRY9J0S7deup7+/whubN8ndMtHxaMX9WX7CodX24nJA2nqH
 VwwYhQ5sSlJlJI3a4Qe0D/itu83w17UAQuHwSF6tXOyV8oHfpkHE5O/BW1YqT8fAI9m6l0J
 kIZOhHj9K2EsPL/tLsOFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HbWym6I3AGw=:WbOrz5eeCmr7vegEWxVb0U
 tnY5QUzKTMC/+n2aFfsAbRJimNX5bTHRv7dS8nCRW6qjtdJgxd5zYJ1K2xbuboyqqwnCkhb5o
 qwAy/ZCrXzGFyZitAfId+5gQBR8EDpOY3fy+tFxEkLdKpLKOhFOXS2xI1mLNo9Jgbdmy/C30l
 Smq/WFKZJE8n2qzRR0cX2k+uLKTKl9WoktfIbhlNQsAEEGJ9V/s0wmmpmsBWvHpucNk7TCJus
 lyd+27ZpTqG/7axvQskTXoUyjWI1DK+uiXJX4iVPGtHmohFDtyfPt7nk4kx5slJ2XVosAyPnX
 PjklvHnbj8QYl/FuK5vWHHDlt3/yNEZXYIGRbmFQibYagEJrBMjB898n4al38qnVORW78CX0q
 BDVxQEWigIR5YOnc7rBxYQ6fSLaa6rempicD0cbJSJiVqaeb+dFUZa9qN+k5hdfSZV1nvsOcY
 h6NxhyjfB2tUBOLfYkUjroSgQy4iNQduyCmv3hKqXkR/0RjnEv/pY5GeSRoINeqzkc4OI6QbO
 kZJMXav3F6lwcK5gGw/yIJDzTMgUJrkoHCwszBCIxU7cTmLaMaVD1dBY7y4zWlaLtZynSxE/G
 k6Inng75v45si3KZt5ZOTlvteNA+EDTW/RBSjtmMWWkZYe0PmXs62JUjDOl2p5tMtpatI2I6I
 S2PSBXCFMzS69X6doaGEGI9pjyFPscAahkPsd9czTl/r6TjZsF3BcYOEreOFfgkM0P0y3AhIu
 YrIpL3wpALuZOFj+XjT0rII7mXEkOyHxh/r80tDJ8XbWn1RgTs30UfcssSmh9kzoC4xyWFVaw
 2hXPGHhlk0ZFbQ6AjdaDSBM1Sr3Hv3etK8gaiKL3MYAtIMW3+5UCgPPFJ8G2spYO/3LKCCczt
 7F7JDWwkTRfwUJkMx6Lg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/10/2018 à 14:43, Jann Horn a écrit :
> On Tue, Oct 9, 2018 at 12:38 PM Laurent Vivier <laurent@vivier.eu> wrote:
>> This patch allows to have a different binfmt_misc configuration
>> for each new user namespace. By default, the binfmt_misc configuration
>> is the one of the previous level, but if the binfmt_misc filesystem is
>> mounted in the new namespace a new empty binfmt instance is created and
>> used in this namespace.
>>
>> For instance, using "unshare" we can start a chroot of an another
>> architecture and configure the binfmt_misc interpreter without being root
>> to run the binaries in this chroot.
> [...]
>> @@ -823,12 +847,34 @@ static const struct super_operations s_ops = {
>>  static int bm_fill_super(struct super_block *sb, void *data, int silent)
>>  {
>>         int err;
>> +       struct user_namespace *ns = sb->s_user_ns;
>>         static const struct tree_descr bm_files[] = {
>>                 [2] = {"status", &bm_status_operations, S_IWUSR|S_IRUGO},
>>                 [3] = {"register", &bm_register_operations, S_IWUSR},
>>                 /* last one */ {""}
>>         };
>>
>> +       /* create a new binfmt namespace
>> +        * if we are not in the first user namespace
>> +        * but the binfmt namespace is the first one
>> +        */
>> +       if (READ_ONCE(ns->binfmt_ns) == NULL) {
>> +               struct binfmt_namespace *new_ns;
>> +
>> +               new_ns = kmalloc(sizeof(struct binfmt_namespace),
>> +                                GFP_KERNEL);
>> +               if (new_ns == NULL)
>> +                       return -ENOMEM;
>> +               INIT_LIST_HEAD(&new_ns->entries);
>> +               new_ns->enabled = 1;
>> +               rwlock_init(&new_ns->entries_lock);
>> +               new_ns->bm_mnt = NULL;
>> +               new_ns->entry_count = 0;
>> +               /* ensure new_ns is completely initialized before sharing it */
>> +               smp_wmb();
>> +               WRITE_ONCE(ns->binfmt_ns, new_ns);
>> +       }
> 
> You're still not preventing a concurrent race of two mount() calls,
> right? What prevents two instances of this code block from running
> concurrently in two different namespaces? I think you want to take
> some sort of global lock around this.
> 

My guess was we have only one binfmt superblock by user namespace, so as
we can't have duplicate superblock, we will not have duplicate binfmt_ns
structure. This function is only called once in the namespace and I
think the superblock creation is already protected by some kind of lock.

But I'm not a VFS expert, if someone wants to clarify the situation,
please go ahead.

Thanks,
Laurent




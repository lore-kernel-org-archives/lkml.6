Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A15C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439632064A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439632064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeI2RQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:16:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50024 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeI2RQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:16:52 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8TAmR9G097374;
        Sat, 29 Sep 2018 19:48:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Sat, 29 Sep 2018 19:48:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8TAmN6l097353
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 29 Sep 2018 19:48:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
To:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180925001832.18322-1-keescook@chromium.org>
 <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
 <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <eda428eb-f6e1-f048-a394-251953c388b6@i-love.sakura.ne.jp>
Date:   Sat, 29 Sep 2018 19:48:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/29 5:01, Kees Cook wrote:
> On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/24/2018 5:18 PM, Kees Cook wrote:
>>> v3:
>>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>>
>> Kees, you can add my
>>
>>         Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>>
>> for this entire patch set. Thank you for taking this on, it's
>> a significant and important chunk of the LSM infrastructure
>> update.
> 
> Thanks!
> 
> John, you'd looked at this a bit too -- do the results line up with
> your expectations?
> 
> Any thoughts from SELinux, TOMOYO, or IMA folks?

I'm OK with this approach. Thank you.



Just wondering what is "__lsm_name_##lsm" for...

+#define DEFINE_LSM(lsm)                                                        \
+       static const char __lsm_name_##lsm[] __initconst                \
+               __aligned(1) = #lsm;                                    \
+       static struct lsm_info __lsm_##lsm                              \
+               __used __section(.lsm_info.init)                        \
+               __aligned(sizeof(unsigned long))                        \
+               = {                                                     \
+                       .name = __lsm_name_##lsm,                       \
+
+#define END_LSM          }

We could do something like below so that funny END_LSM is not required?
I felt } like a typo error at the first glance. What we need is to
gather into one section with appropriate alignment, isn't it?

#define LSM_INFO                                                        \
	static struct lsm_info __lsm_                                   \
		__used __section(.lsm_info.init)                        \
		__aligned(sizeof(unsigned long))                        \

LSM_INFO = {
	.name = "tomoyo",
	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
	.init = tomoyo_init,
};

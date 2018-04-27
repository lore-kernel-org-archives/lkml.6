Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZohI2oH6fViWos953NmpZE5sKde7V8TIkUqJPYQRDnG4B4bZXcwII6UJj79VMMbMd8nx/Jl
ARC-Seal: i=1; a=rsa-sha256; t=1524847194; cv=none;
        d=google.com; s=arc-20160816;
        b=ikYD4Bl4tZD+ALWBx6oqevrR12eD78fuIInRk9jyNV2EmTfO97k8AJZm1hbN0mNrgP
         fgYiWb1QqTKhw4BSTJTh73Ijx0gbW2sm94ILVjF5FTEMcO0jkhBoM0EN9kAgbKBIiqxN
         nvD14hv6+jp7LvxnR/S59l3i25xvAIGj6/R8aW+HxW2Ix3wk+ht/cqNR/hxYVH1EHyRq
         j4mmCL98b6FkCA+Rtzn8nCcfHMAZbiI5Z49pt8wzawgUrz8Zp6DaPyltGmWM93lXddrF
         wuaT8mNyfUHn34T7bhPvNDhcYTbIKPoQpJrRHBhpX2HIHXd/JNGZGEhm3K/hCN/y9V5D
         9EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=keb6te214IJKr2JkRITF6KlT5jjkjohbCirvoSbiXrw=;
        b=DEWpSkmoVE6judNSr6PIp/n5xG4OTKeDxeJ/OSPIw8M1n41FuGlXDuVsiRV0eBtjot
         Ml5+tzdWRCF9EVuiP5JzBAuBkh5kxfeZc0KjsP1Q1eVGAKBb9M2ImBcB20AaVqcFM+r9
         QgBL0Dzl5Yv3TxyUMjLQDEp4Wvu5H3L2nipsrjN5hMNfo0Qlz+Jeyrc5R+IxS5hdAemg
         Kt+qKEwDOQnzIu01BQMeNHk/vmE+e56PG2+uXLt3qRylC6em9cn48S9bYQipcs/sdjTX
         hVEpz7Q62I5OWI4i6S5n8yAhzo2wNl6uoXFyObR3yb9r8DaSrMG8mHUpbpizo54cZxp5
         h0Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180427102306.8617-1-christian.brauner@ubuntu.com>
	<20180427102306.8617-2-christian.brauner@ubuntu.com>
Date: Fri, 27 Apr 2018 11:39:44 -0500
In-Reply-To: <20180427102306.8617-2-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Fri, 27 Apr 2018 12:23:05 +0200")
Message-ID: <878t987gdr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fC6PV-0006QA-6f;;;mid=<878t987gdr.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18itCaU2AX94q+VoRn5EOd9fCgnL7/NYJ8=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3739]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_04 7+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 165 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 6 (3.5%), b_tie_ro: 4.7 (2.9%), parse: 0.76 (0.5%),
	extract_message_metadata: 10 (6.1%), get_uri_detail_list: 1.16 (0.7%),
	tests_pri_-1000: 3.9 (2.4%), tests_pri_-950: 1.20 (0.7%), tests_pri_-900:
	1.02 (0.6%), tests_pri_-400: 18 (10.9%), check_bayes: 17 (10.2%), b_tokenize:
	4.3 (2.6%), b_tok_get_all: 6 (3.6%), b_comp_prob: 1.29 (0.8%),
	b_tok_touch_all: 3.2 (2.0%), b_finish: 0.71 (0.4%), tests_pri_0: 117 (70.9%),
	check_dkim_signature: 0.37 (0.2%), check_dkim_adsp: 3.4 (2.1%),
	tests_pri_500: 4.6 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next 1/2 v3] uevent: add alloc_uevent_skb() helper
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894615374917391?=
X-GMAIL-MSGID: =?utf-8?q?1598918171108406687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@ubuntu.com> writes:

> This patch adds alloc_uevent_skb() in preparation for follow up patches.
>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  lib/kobject_uevent.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 15ea216a67ce..c3cb110f663b 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -296,6 +296,31 @@ static void cleanup_uevent_env(struct subprocess_info *info)
>  }
>  #endif
>  
> +static struct sk_buff *alloc_uevent_skb(struct kobj_uevent_env *env,
> +					const char *action_string,
> +					const char *devpath)
> +{
> +	struct sk_buff *skb = NULL;
> +	char *scratch;
> +	size_t len;
> +
> +	/* allocate message with maximum possible size */
> +	len = strlen(action_string) + strlen(devpath) + 2;
> +	skb = alloc_skb(len + env->buflen, GFP_KERNEL);
> +	if (!skb)
> +		return NULL;
> +
> +	/* add header */
> +	scratch = skb_put(skb, len);
> +	sprintf(scratch, "%s@%s", action_string, devpath);
> +
> +	skb_put_data(skb, env->buf, env->buflen);
> +
> +	NETLINK_CB(skb).dst_group = 1;

nit:
     We might want to explicitly set NETLINK_CB(skb).portid to 0 and
     NETLINK_CB(skb).creds.uid to GLOBAL_ROOT_UID and
     NETLINK_CB(skb).creds.gid to GLOBAL_ROOT_GID here
     just to make it clear this is happening.

     It is not a problem because they __alloc_skb memsets to 0 the
     fields of struct sk_buff that it does not initialize.  And these
     are the zero values.

     Still it would be nice to be able to look at the code and quickly
     see these are the values being set.

Eric

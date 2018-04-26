Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx49YlVQAxfMVrubQD66gAE4x8s/dUqi7PF0urhQQl1o6YrWuFUfW9sHJkBQELaLRks1G3B3F
ARC-Seal: i=1; a=rsa-sha256; t=1524761345; cv=none;
        d=google.com; s=arc-20160816;
        b=D6W1aJi2J1SaI9OQJged8xRDbykp5HYDjUgCgJ9r7VRCNt17W94g1x2qe3eb2zkhXh
         +e1LZ8nEed6b9abXYFqQezuwLvP3p7xFxPKfXXRJ53dajWMaz2pGxCQYs7aAnQQA1wYA
         C2kmVraGjwTt1/Kl6UQdQy+F+gaGfSpw2UX2rUvCenEZccScFOaBVss50JmHLYW3E6Yp
         j5Zt/YZYhdyD73KhQ9sXmd4wGkSc2w+x1DK0xYNOZQCesEtt5J0vbslm5cwZBcIpGSAx
         K1zLIVvNpk+cUc43G0kizGP60BivvqXAIz+ILyIKy5LpFFnodpRncQlhlEpcvCnSn3HP
         P+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=DiNhOay19UsV04X0ihVuECHewobxU7e7obIdvRM1aW4=;
        b=KragMIDNTlaB8ri+nfLYM8O5JeSZhZ6/OLHynfgs1sf+wjevla7s9R8+DHynr1olaX
         jLFGIrEmq0tLvE2y74/YXdIrEJRz71ce/pd0nQLWbIvZaTVraMzH12JCXZqY77xthGSN
         IZ+eOZk1oEUV8pHsmk/fXWGb+3UIZn+fqHY2ngqowEZgesz1sVHA5Ti+fdGQ+0IUKOHd
         R4GXguvlfIw0GbtO0sCYtZRgV0HxLJk1uEcyNKk0Uq7vxwKhyXuhSA5avBThn5rcfNjJ
         zCP8ky4Kdr4FuvWmNGfvpBpXzTlx8pZ7cXKy+HphWi8EczTr/xzp6rxKzoRl8JxXXHyL
         jcIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: David Miller <davem@davemloft.net>,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180424204335.12904-1-christian.brauner@ubuntu.com>
	<20180424204335.12904-2-christian.brauner@ubuntu.com>
	<87po2oz0s8.fsf@xmission.com>
	<CAPP7u0WH9w26Y9ai-EQTTeq7Rz_=7u2-=t4nhHmjwh-UAiyqeQ@mail.gmail.com>
	<87wowww6p8.fsf@xmission.com> <20180426161353.GA2014@gmail.com>
Date: Thu, 26 Apr 2018 11:47:19 -0500
In-Reply-To: <20180426161353.GA2014@gmail.com> (Christian Brauner's message of
	"Thu, 26 Apr 2018 18:13:55 +0200")
Message-ID: <871sf1q5ig.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBk4c-0002ZB-7o;;;mid=<871sf1q5ig.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18lZQi318bYzHw5DzpI5VUjz4inLzAWWbk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15028 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 2.5 (0.0%), b_tie_ro: 1.78 (0.0%), parse: 0.82 (0.0%),
	extract_message_metadata: 15 (0.1%), get_uri_detail_list: 2.9 (0.0%),
	tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
	0.97 (0.0%), tests_pri_-400: 29 (0.2%), check_bayes: 28 (0.2%), b_tokenize:
	10 (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.7 (0.0%), b_tok_touch_all:
	2.6 (0.0%), b_finish: 0.58 (0.0%), tests_pri_0: 279 (1.9%),
	check_dkim_signature: 0.64 (0.0%), check_dkim_adsp: 3.9 (0.0%),
	tests_pri_500: 14694 (97.8%), poll_dns_idle: 14683 (97.7%), rewrite_mail:
	0.00 (0.0%)
Subject: Re: [PATCH net-next 1/2 v2] netns: restrict uevents
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598828152551519741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

> On Tue, Apr 24, 2018 at 06:00:35PM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian.brauner@canonical.com> writes:
>> 
>> > On Wed, Apr 25, 2018, 00:41 Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >
>> >  Bah. This code is obviously correct and probably wrong.
>> >
>> >  How do we deliver uevents for network devices that are outside of the
>> >  initial user namespace? The kernel still needs to deliver those.
>> >
>> >  The logic to figure out which network namespace a device needs to be
>> >  delivered to is is present in kobj_bcast_filter. That logic will almost
>> >  certainly need to be turned inside out. Sign not as easy as I would
>> >  have hoped.
>> >
>> > My first patch that we discussed put additional filtering logic into kobj_bcast_filter for that very reason. But I can move that logic
>> > out and come up with a new patch.
>> 
>> I may have mis-understood.
>> 
>> I heard and am still hearing additional filtering to reduce the places
>> the packet is delievered.
>> 
>> I am saying something needs to change to increase the number of places
>> the packet is delivered.
>> 
>> For the special class of devices that kobj_bcast_filter would apply to
>> those need to be delivered to netowrk namespaces  that are no longer on
>> uevent_sock_list.
>> 
>> So the code fundamentally needs to split into two paths.  Ordinary
>> devices that use uevent_sock_list.  Network devices that are just
>> delivered in their own network namespace.
>> 
>> netlink_broadcast_filtered gets to go away completely.
>
> The split *might* make sense but I think you're wrong about removing the
> kobj_bcast_filter. The current filter doesn't operate on the uevent
> socket in uevent_sock_list itself it rather operates on the sockets in
> mc_list. And if socket in mc_list can have a different network namespace
> then the uevent_socket itself then your way won't work. That's why my
> original patch added additional filtering in there. The way I see it we
> need something like:

We already filter the sockets in the mc_list by network namespace.

When a packet is transmitted with netlink_broadcast it is only
transmitted within a single network namespace.

Even in the case of a NETLINK_F_LISTEN_ALL_NSID socket the skb is tagged
with it's source network namespace so no confusion will result, and the
permission checks have been done to make it safe. So you can safely
ignore that case.  Please ignore that case.  It only needs to be
considered if refactoring af_netlink.c

When I added netlink_broadcast_filtered I imagined that we would need
code that worked across network namespaces that worked for different
namespaces.   So it looked like we would need the level of granularity
that you can get with netlink_broadcast_filtered.  It turns out we don't
and that it was a case of over design.  As the only split we care about
is per network namespace there is no need for
netlink_broadcast_filtered.

> init_user_ns_broadcast_filtered(uevent_sock_list, kobj_bcast_filter);
> user_ns_broadcast_filtered(uevent_sock_list,kobj_bcast_filter);
>
> The question that remains is whether we can rely on the network
> namespace information we can gather from the kobject_ns_type_operations
> to decide where we want to broadcast that event to. So something
> *like*:

We can.  We already do.  That is what kobj_bcast_filter implements.

> 	ops = kobj_ns_ops(kobj);
> 	if (!ops && kobj->kset) {
> 		struct kobject *ksobj = &kobj->kset->kobj;
> 		if (ksobj->parent != NULL)
> 			ops = kobj_ns_ops(ksobj->parent);
> 	}
>
> 	if (ops && ops->netlink_ns && kobj->ktype->namespace)
> 		if (ops->type == KOBJ_NS_TYPE_NET)
> 			net = kobj->ktype->namespace(kobj);

Please note the only entry in the enumeration in the kobj_ns_type
enumeration other than KOBJ_NS_TYPE_NONE is KOBJ_NS_TYPE_NET.  So the
check for ops->type in this case is redundant.

That is something else that could be simplifed.  At the time it was the
necessary to get the sysfs changes merged.

> 	if (!net || net->user_ns == &init_user_ns)
> 		ret = init_user_ns_broadcast(env, action_string, devpath);
> 	else
> 		ret = user_ns_broadcast(net->uevent_sock->sk, env,
> 					action_string, devpath);

Almost.

	if (!net)
        	kobject_uevent_net_broadcast(kobj, env, action_string,
        					dev_path);
	else
        	netlink_broadcast(net->uevent_sock->sk, skb, 0, 1, GFP_KERNEL);


I am handwaving to get the skb in the netlink_broadcast case but that
should be enough for you to see what I am thinking.

My only concern with the above is that we almost certainly need to fix
the credentials on the skb so that userspace does not drop the packet
sent to a network namespace because it has the credentials that will
cause userspace to drop the packet today.

But it should be straight forward to look at net->user_ns, to fix the
credentials.

Eric

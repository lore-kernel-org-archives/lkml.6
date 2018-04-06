Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx4/9cx+Kp4aC2v3h+OrprnTX7YNwA5wKITPu6vhgwwDxTtvvBLaY/cHRLMixO2DlryN37q7n
ARC-Seal: i=1; a=rsa-sha256; t=1523026015; cv=none;
        d=google.com; s=arc-20160816;
        b=WngyrZ8h/dGsjtqSWN7dFY/ml6taUEpkozPOL9kXSVfbbnuEf51XTvjggOKqTv5UwR
         Tx4U636y4txhEh/x+y9PlL/g6gFPBNrJZYJhDg6y/JocRsJw4LsFllEkDylr5wtZ1oNp
         w8SIJzu5K1uGgTRjk5F4VgU3qukMMUaTSnV/+Dhr3yVTUJEz7WJfbywF7jFL+o5N5Gm/
         Hk7n4lNmikQBvwIit/Pv6keBAOS7EJxnAKrxnUIWsZT+Eud729VBAyYuZzVyuZeCjXHI
         UlUe5uFLT+XlCscdUakT9DOpmFRAVHyaxF6FEFie/Rdr1f7NB5VamycFmkzj93zp4lHp
         HEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=0SDY3Sbvvqoe7BTKrt4aCAWR4AWqmZFbmj4P73m9+/M=;
        b=f9N8UET1DHnBxORiXuCJ4iguc3YNdkIOkJgrAWd1IVWvGTrYN1bRZyyQRqVcuFN5HD
         gq02sQgok6651iMye9OqsJ8j6EB6qu+olvpsmfxJmZTqjPy6IwdlM3dlXyy9YzNVqG/x
         LxrZ1ci3JLgkUCNu/hcwkNoWzFnw147vhlkixQkzpEMzkkVzC4UXDL55zRQWdTvcIucC
         sCgF2PD2eCXtDAws5AekqjuRANRtUVKj0RfcdPH5EZOkRN38G/8Oz7YKTd0VMl6w1zwd
         edMRHhdAUVjopohdmF5ISpmR+/geQGgf6hhoQtTE8UQeTe/ipcWqgzBh4vx76IgXX5x1
         jNcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,  davem@davemloft.net,  gregkh@linuxfoundation.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  serge@hallyn.com
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
	<442e89b8-e947-6eeb-1bcb-fa28f22a25f0@virtuozzo.com>
	<20180405140709.GA1697@gmail.com>
	<941de2b9-332f-75fc-f8ac-4059a9b5426f@virtuozzo.com>
	<20180405144130.GB26043@gmail.com> <87in953ryi.fsf@xmission.com>
	<20180406130704.GB9263@gmail.com>
Date: Fri, 06 Apr 2018 09:45:41 -0500
In-Reply-To: <20180406130704.GB9263@gmail.com> (Christian Brauner's message of
	"Fri, 6 Apr 2018 15:07:05 +0200")
Message-ID: <874lko2y22.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f4Sdf-000244-2e;;;mid=<874lko2y22.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18N+ZfKz6FoyBPmSKduJpsCN8yVIIuF+Ss=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 664 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 2.9 (0.4%), b_tie_ro: 2.0 (0.3%), parse: 1.34 (0.2%),
	extract_message_metadata: 19 (2.8%), get_uri_detail_list: 7 (1.1%),
	tests_pri_-1000: 7 (1.0%), tests_pri_-950: 1.14 (0.2%), tests_pri_-900: 0.96
	(0.1%), tests_pri_-400: 45 (6.8%), check_bayes: 44 (6.6%), b_tokenize: 18
	(2.8%), b_tok_get_all: 15 (2.2%), b_comp_prob: 4.4 (0.7%), b_tok_touch_all:
	4.2 (0.6%), b_finish: 0.59 (0.1%), tests_pri_0: 579 (87.2%),
	check_dkim_signature: 0.65 (0.1%), check_dkim_adsp: 2.5 (0.4%),
	tests_pri_500: 4.2 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next] netns: filter uevents correctly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1597008527446313614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

> On Thu, Apr 05, 2018 at 10:59:49PM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian.brauner@canonical.com> writes:
>> 
>> > On Thu, Apr 05, 2018 at 05:26:59PM +0300, Kirill Tkhai wrote:
>> >> On 05.04.2018 17:07, Christian Brauner wrote:
>> >> > On Thu, Apr 05, 2018 at 04:01:03PM +0300, Kirill Tkhai wrote:
>> >> >> On 04.04.2018 22:48, Christian Brauner wrote:
>> >> >>> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
>> >> >>>
>> >> >>> enabled sending hotplug events into all network namespaces back in 2010.
>> >> >>> Over time the set of uevents that get sent into all network namespaces has
>> >> >>> shrunk. We have now reached the point where hotplug events for all devices
>> >> >>> that carry a namespace tag are filtered according to that namespace.
>> >> >>>
>> >> >>> Specifically, they are filtered whenever the namespace tag of the kobject
>> >> >>> does not match the namespace tag of the netlink socket. One example are
>> >> >>> network devices. Uevents for network devices only show up in the network
>> >> >>> namespaces these devices are moved to or created in.
>> >> >>>
>> >> >>> However, any uevent for a kobject that does not have a namespace tag
>> >> >>> associated with it will not be filtered and we will *try* to broadcast it
>> >> >>> into all network namespaces.
>> >> >>>
>> >> >>> The original patchset was written in 2010 before user namespaces were a
>> >> >>> thing. With the introduction of user namespaces sending out uevents became
>> >> >>> partially isolated as they were filtered by user namespaces:
>> >> >>>
>> >> >>> net/netlink/af_netlink.c:do_one_broadcast()
>> >> >>>
>> >> >>> if (!net_eq(sock_net(sk), p->net)) {
>> >> >>>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
>> >> >>>                 return;
>> >> >>>
>> >> >>>         if (!peernet_has_id(sock_net(sk), p->net))
>> >> >>>                 return;
>> >> >>>
>> >> >>>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>> >> >>>                              CAP_NET_BROADCAST))
>> >> >>>         j       return;
>> >> >>> }
>> >> >>>
>> >> >>> The file_ns_capable() check will check whether the caller had
>> >> >>> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
>> >> >>> namespace of interest. This check is fine in general but seems insufficient
>> >> >>> to me when paired with uevents. The reason is that devices always belong to
>> >> >>> the initial user namespace so uevents for kobjects that do not carry a
>> >> >>> namespace tag should never be sent into another user namespace. This has
>> >> >>> been the intention all along. But there's one case where this breaks,
>> >> >>> namely if a new user namespace is created by root on the host and an
>> >> >>> identity mapping is established between root on the host and root in the
>> >> >>> new user namespace. Here's a reproducer:
>> >> >>>
>> >> >>>  sudo unshare -U --map-root
>> >> >>>  udevadm monitor -k
>> >> >>>  # Now change to initial user namespace and e.g. do
>> >> >>>  modprobe kvm
>> >> >>>  # or
>> >> >>>  rmmod kvm
>> >> >>>
>> >> >>> will allow the non-initial user namespace to retrieve all uevents from the
>> >> >>> host. This seems very anecdotal given that in the general case user
>> >> >>> namespaces do not see any uevents and also can't really do anything useful
>> >> >>> with them.
>> >> >>>
>> >> >>> Additionally, it is now possible to send uevents from userspace. As such we
>> >> >>> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
>> >> >>> namespace of the network namespace of the netlink socket) userspace process
>> >> >>> make a decision what uevents should be sent.
>> >> >>>
>> >> >>> This makes me think that we should simply ensure that uevents for kobjects
>> >> >>> that do not carry a namespace tag are *always* filtered by user namespace
>> >> >>> in kobj_bcast_filter(). Specifically:
>> >> >>> - If the owning user namespace of the uevent socket is not init_user_ns the
>> >> >>>   event will always be filtered.
>> >> >>> - If the network namespace the uevent socket belongs to was created in the
>> >> >>>   initial user namespace but was opened from a non-initial user namespace
>> >> >>>   the event will be filtered as well.
>> >> >>> Put another way, uevents for kobjects not carrying a namespace tag are now
>> >> >>> always only sent to the initial user namespace. The regression potential
>> >> >>> for this is near to non-existent since user namespaces can't really do
>> >> >>> anything with interesting devices.
>> >> >>>
>> >> >>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>> >> >>> ---
>> >> >>>  lib/kobject_uevent.c | 10 +++++++++-
>> >> >>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> >> >>>
>> >> >>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> >> >>> index 15ea216a67ce..cb98cddb6e3b 100644
>> >> >>> --- a/lib/kobject_uevent.c
>> >> >>> +++ b/lib/kobject_uevent.c
>> >> >>> @@ -251,7 +251,15 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>> >> >>>  		return sock_ns != ns;
>> >> >>>  	}
>> >> >>>  
>> >> >>> -	return 0;
>> >> >>> +	/*
>> >> >>> +	 * The kobject does not carry a namespace tag so filter by user
>> >> >>> +	 * namespace below.
>> >> >>> +	 */
>> >> >>> +	if (sock_net(dsk)->user_ns != &init_user_ns)
>> >> >>> +		return 1;
>> >> >>> +
>> >> >>> +	/* Check if socket was opened from non-initial user namespace. */
>> >> >>> +	return sk_user_ns(dsk) != &init_user_ns;
>> >> >>>  }
>> >> >>>  #endif
>> >> >>
>> >> >> So, this prohibits to listen events of all devices except network-related
>> >> >> in containers? If it's so, I don't think it's a good solution. Uevents is not
>> >> > 
>> >> > No, this is not correct: As it is right now *without my patch* no
>> >> > non-initial user namespace is receiving *any uevents* but those
>> >> > specifically namespaced such as those for network devices. This patch
>> >> > doesn't change that at all. The commit message outlines this in detail
>> >> > how this comes about.
>> >> > There is only one case where this currently breaks and this is as I
>> >> > outlined explicitly in my commit message when you create a new user
>> >> > namespace and map container(0) -> host(0). This patch fixes this.
>> >> 
>> >> Could you please point the place, where non-initial user namespaces are filtered?
>> >> I only see the kobj_bcast_filter() logic, and it used to return 0, which means "accepted".
>> >> Now it will return 1 sometimes.
>> >
>> > Oh sure, it's in the commit message though. The callchain is
>> > lib/kobject_uevent.c:kobject_uevent_net_broadcast() ->
>> > nnet/netlink/af_netlink.c:netlink_broadcast_filtered() ->
>> > net/netlink/af_netlink.c:do_one_broadcast():
>> >
>> > This codepiece will check whether the openened socket holds
>> > CAP_NET_BROADCAST in the user namespace of the target network namespace
>> > which it won't because we don't have device namespaces and all devices
>> > belong to the initial set of namespaces.
>> >
>> >         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>> >                              CAP_NET_BROADCAST))
>> >         j       return;
>> >
>> 
>> The above that only applies if someone has set NETLINK_F_LISTEN_ALL_NSID
>> on their socket and has had someone with the appropriate privileges
>> assign a peerrnetid.
>> 
>> All of which is to say that file_ns_capable is not nearly as applicable
>> as it might be, and if you can pass the other two checks I think it is
>> pointless (because the peernet attributes are not generated for
>> kobj_uevents) but valid to receive events from outside your network
>> namespace.
>> 
>> 
>> I might be missing something but I don't see anything excluding network
>> namespaces owned by !init_user_ns excluded from the kobject_uevent
>> logic.
>> 
>> The uevent_sock_list has one entry per network namespace. And
>> kobject_uevent_net_broacast appears to walk each one.
>
> Yeah, it definitely does.
>
>> 
>> I had a memory of filtering uevent messages and I had a memory
>> that the netlink_has_listeners had a per network namespace effect.
>> Neither seems true from my inspection of the code tonight.
>
> Yeah, I drew the same conclusion.
>
>> 
>> If we are not filtering ordinary uevents at least at the user namespace
>> level that does seem to be at least a nuisance.
>
> This patch would filter based on user namespace and bump it from "we're
> accidently doing the right thing" to "we're doing the right on purpose"
> and without accidently leaking uevents in some corner cases.
> Using kobj_bcast_filter() for this seems like the right thing to do.
> This sounds like you don't disagree with the approach I'm taking here?

How are we accidentally filtering?  If we can not describe how the code
currently works to achieve something we don't understand it well enough
to change it.



> On a sidenote, it also very much feels like we're leaking information if
> we're not filtering based on user namespaces on purpose. Non-initial
> user namespaces should not be able to receive information about device
> attribues simply via netlink uevent messages. At least not *trivially*
> [1] by opening a netlink uevent socket.

This is not at all about isolation.  Devices don't belong to user
namespaces.  This is about it being useless/silly to send events
to those sockets as the receiver could not do anything with the uevent.
At a practical level there should be no receivers.  Plus performance
issues.  At least my memory is that any unprivileged user on the system
is allowed to listen to those events.

At least at one point udev listening and reacting to events in every
network namespace in containers was a significant slow down on the
system.

The report was that adding netlink_has_listeners greatly sped up uevent
sending.   That testing appears faulty.  I think the real gain was
userspace not listening to uevents in every container.

Which means uevent injection for containers has some real technical
challenges to overcome before it can be wide spread.

>> Christian can you dig a little deeper into this.  I have a feeling that
>> there are some real efficiency improvements that we could make to
>> kobject_uevent_net_broadcast if nothing else.
>
> Yeah, for sure! I already started doing this. This patch here is
> basically a preparatory patch for that work which is on my todo.

Limiting the network namespaces on uevent_sock_list to just network
namespaces owned by the initial user namespaces would be a lot better
than your patch.


At a practical level I am concerned what will happen when we stand up a
uevent listener aka udev in say 100 or maybe 1000 unprivileged
containers on a system.  History suggests the current data structures
won't scale to the problem, and the fixes that were put in place kernel
side only did not change anything.  It was only the userspace fixes
that made a difference.

Which suggests either improving the isolation between network namespaces
for netlink multicast sockets or putting:


	if (!net_eq(sock_net(sk), p->net)) {
		if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
			return;

		if (!peernet_has_id(sock_net(sk), p->net))
			return;

		if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
				     CAP_NET_BROADCAST))
			return;
	}

In a filter and having an appropriate filter so that
netlink_broadcast_filtered only needs to be called once from
kobject_uevent_net_broadcast.

It is more difficult but in practice I expect we have far more to gain
by fixing the mc_list and the netlink_has_listeners function to be per
network namespace basis.  Handling the NETLINK_F_LISTEN_ALL_NSID will
be trickier in that case but the current semantics appear correct
for that case.

But before we do anything we have to test and see if the assertion
that we don't make it to netlink listeners in network namespaces
that are outside of the init_user_ns is true.   If it is true we need to
find the code that makes it true.

Eric

Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx49tW9YefY0fX9EBUK2orG/ZQUA8Cu7jEJuRhxhd5uop8PF1rWyn3zgt3GHzfUU4d+Vc/+Qb
ARC-Seal: i=1; a=rsa-sha256; t=1524610938; cv=none;
        d=google.com; s=arc-20160816;
        b=qd4mt5wsf3I+oizTMyjZA8tN/z2P9OuiA43gqj0TNi/3q4eU5IRaBKnGT2hrNzK+37
         3MxUPNxldUJmTUHti5YlZfgh1Vfib2P/fPmr6Axdm/Sbfnkdc39DY3ehAhxA35nDYTpU
         FaoY61OwSfM5gsRr00eGmbmdPtXIn8eXdmYG+GILsEeYJDAmKtDcByJ4QdZj0CyoDWKr
         2dc62fME/YQNfImq7XTNyUOP6hMFxL4KLSTYc/WC5yu3eyDFBUUzBkLthdZMFBBfOmNw
         jV4feZ6N0BCtd2Fzctz+LFqZmTqVPdN4lvC2wxo0VmcpTivtK6h8w0AjA6whp6IPiB7o
         w1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=/wt8DmfWqchwAmGMkFWHk5uk1DpjUPKUr/VMG2wc4e4=;
        b=lsQEhasZoBSbX6/tFHHfoTq0GEQ85x6/Ras+NriO0RAj220OxyB6QxsCvVZ+SYG0vk
         OZovM/ovcTj5vBzj4W5xLmRadBc1YrnPnK+P8ActnTv4wFXplsuDwPtMGrifbJxpDsIB
         U9BBvcnGuKflZMuGRvQfDw0z0Ovr/CvECBa9ioX77M9vvUCpp/M6h+g0jlykD0neKibm
         Xsok1ndxIHUT1tvgfonARYgg4iwAj0fJLiqpgt/5duhuDc/wO+R836eWakIycw6oqb5E
         jViy3qESSek1iaJ8mqvkvcJWQTencWE01PXtfv82mIb95I3+l9BD2RofCh+dghcfSAP1
         NQWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,  David Miller <davem@davemloft.net>,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com,  gregkh@linuxfoundation.org
References: <20180424204335.12904-1-christian.brauner@ubuntu.com>
	<20180424204335.12904-2-christian.brauner@ubuntu.com>
	<87po2oz0s8.fsf@xmission.com>
	<CAPP7u0WH9w26Y9ai-EQTTeq7Rz_=7u2-=t4nhHmjwh-UAiyqeQ@mail.gmail.com>
Date: Tue, 24 Apr 2018 18:00:35 -0500
In-Reply-To: <CAPP7u0WH9w26Y9ai-EQTTeq7Rz_=7u2-=t4nhHmjwh-UAiyqeQ@mail.gmail.com>
	(Christian Brauner's message of "Tue, 24 Apr 2018 22:47:37 +0000")
Message-ID: <87wowww6p8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB6wi-0001Vj-6K;;;mid=<87wowww6p8.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19JqZJxiJvJbqLyWRPScOvLwjhVQCiD40w=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 T_XMDrugObfuBody_14 obfuscated drug references
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15032 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 2.5 (0.0%), b_tie_ro: 1.69 (0.0%), parse: 0.89 (0.0%),
	extract_message_metadata: 21 (0.1%), get_uri_detail_list: 4.7 (0.0%),
	tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.16 (0.0%), tests_pri_-900:
	0.99 (0.0%), tests_pri_-400: 38 (0.2%), check_bayes: 36 (0.2%), b_tokenize:
	14 (0.1%), b_tok_get_all: 12 (0.1%), b_comp_prob: 3.8 (0.0%),
	b_tok_touch_all: 3.8 (0.0%), b_finish: 0.60 (0.0%), tests_pri_0: 453 (3.0%),
	check_dkim_signature: 0.77 (0.0%), check_dkim_adsp: 2.8 (0.0%),
	tests_pri_500: 14510 (96.5%), poll_dns_idle: 14499 (96.4%), rewrite_mail:
	0.00 (0.0%)
Subject: Re: [PATCH net-next 1/2 v2] netns: restrict uevents
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598670439899078522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

> On Wed, Apr 25, 2018, 00:41 Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>  Bah. This code is obviously correct and probably wrong.
>
>  How do we deliver uevents for network devices that are outside of the
>  initial user namespace? The kernel still needs to deliver those.
>
>  The logic to figure out which network namespace a device needs to be
>  delivered to is is present in kobj_bcast_filter. That logic will almost
>  certainly need to be turned inside out. Sign not as easy as I would
>  have hoped.
>
> My first patch that we discussed put additional filtering logic into kobj_bcast_filter for that very reason. But I can move that logic
> out and come up with a new patch.

I may have mis-understood.

I heard and am still hearing additional filtering to reduce the places
the packet is delievered.

I am saying something needs to change to increase the number of places
the packet is delivered.

For the special class of devices that kobj_bcast_filter would apply to
those need to be delivered to netowrk namespaces  that are no longer on
uevent_sock_list.

So the code fundamentally needs to split into two paths.  Ordinary
devices that use uevent_sock_list.  Network devices that are just
delivered in their own network namespace.

netlink_broadcast_filtered gets to go away completely.
The logic of figuring out the network namespace though becomes trickier.

Now it may make sense to have all of that as an additional patch on top
of this one or perhaps a precursor patch that addresses the problem.  We
will unfortunately drop those uevents today because their uids are not
valid.  But they are not delivered anywhere else so to allow them to be
received we need to fix them.

Eric

>
>  Christian Brauner <christian.brauner@ubuntu.com> writes:
>  > commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
>  >
>  > enabled sending hotplug events into all network namespaces back in 2010.
>  > Over time the set of uevents that get sent into all network namespaces has
>  > shrunk a little. We have now reached the point where hotplug events for all
>  > devices that carry a namespace tag are filtered according to that
>  > namespace. Specifically, they are filtered whenever the namespace tag of
>  > the kobject does not match the namespace tag of the netlink socket. One
>  > example are network devices. Uevents for network devices only show up in
>  > the network namespaces these devices are moved to or created in.
>  >
>  > However, any uevent for a kobject that does not have a namespace tag
>  > associated with it will not be filtered and we will broadcast it into all
>  > network namespaces. This behavior stopped making sense when user namespaces
>  > were introduced.
>  >
>  > This patch restricts uevents to the initial user namespace for a couple of
>  > reasons that have been extensively discusses on the mailing list [1].
>  > - Thundering herd:
>  > Broadcasting uevents into all network namespaces introduces significant
>  > overhead.
>  > All processes that listen to uevents running in non-initial user
>  > namespaces will end up responding to uevents that will be meaningless to
>  > them. Mainly, because non-initial user namespaces cannot easily manage
>  > devices unless they have a privileged host-process helping them out. This
>  > means that there will be a thundering herd of activity when there
>  > shouldn't be any.
>  > - Uevents from non-root users are already filtered in userspace:
>  > Uevents are filtered by userspace in a user namespace because the
>  > received uid != 0. Instead the uid associated with the event will be
>  > 65534 == "nobody" because the global root uid is not mapped.
>  > This means we can safely and without introducing regressions modify the
>  > kernel to not send uevents into all network namespaces whose owning user
>  > namespace is not the initial user namespace because we know that
>  > userspace will ignore the message because of the uid anyway. I have
>  > a) verified that is is true for every udev implementation out there b)
>  > that this behavior has been present in all udev implementations from the
>  > very beginning.
>  > - Removing needless overhead/Increasing performance:
>  > Currently, the uevent socket for each network namespace is added to the
>  > global variable uevent_sock_list. The list itself needs to be protected
>  > by a mutex. So everytime a uevent is generated the mutex is taken on the
>  > list. The mutex is held *from the creation of the uevent (memory
>  > allocation, string creation etc. until all uevent sockets have been
>  > handled*. This is aggravated by the fact that for each uevent socket that
>  > has listeners the mc_list must be walked as well which means we're
>  > talking O(n^2) here. Given that a standard Linux workload usually has
>  > quite a lot of network namespaces and - in the face of containers - a lot
>  > of user namespaces this quickly becomes a performance problem (see
>  > "Thundering herd" above). By just recording uevent sockets of network
>  > namespaces that are owned by the initial user namespace we significantly
>  > increase performance in this codepath.
>  > - Injecting uevents:
>  > There's a valid argument that containers might be interested in receiving
>  > device events especially if they are delegated to them by a privileged
>  > userspace process. One prime example are SR-IOV enabled devices that are
>  > explicitly designed to be handed of to other users such as VMs or
>  > containers.
>  > This use-case can now be correctly handled since
>  > commit 692ec06d7c92 ("netns: send uevent messages"). This commit
>  > introduced the ability to send uevents from userspace. As such we can let
>  > a sufficiently privileged (CAP_SYS_ADMIN in the owning user namespace of
>  > the network namespace of the netlink socket) userspace process make a
>  > decision what uevents should be sent. This removes the need to blindly
>  > broadcast uevents into all user namespaces and provides a performant and
>  > safe solution to this problem.
>  > - Filtering logic:
>  > This patch filters by *owning user namespace of the network namespace a
>  > given task resides in* and not by user namespace of the task per se. This
>  > means if the user namespace of a given task is unshared but the network
>  > namespace is kept and is owned by the initial user namespace a listener
>  > that is opening the uevent socket in that network namespace can still
>  > listen to uevents.
>  >
>  > [1]: https://lkml.org/lkml/2018/4/4/739
>  > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>  > ---
>  > Changelog v1->v2:
>  > * patch unchanged
>  > Changelog v0->v1:
>  > * patch unchanged
>  > ---
>  > lib/kobject_uevent.c | 18 ++++++++++++------
>  > 1 file changed, 12 insertions(+), 6 deletions(-)
>  >
>  > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>  > index 15ea216a67ce..f5f5038787ac 100644
>  > --- a/lib/kobject_uevent.c
>  > +++ b/lib/kobject_uevent.c
>  > @@ -703,9 +703,13 @@ static int uevent_net_init(struct net *net)
>  > 
>  > net->uevent_sock = ue_sk;
>  > 
>  > - mutex_lock(&uevent_sock_mutex);
>  > - list_add_tail(&ue_sk->list, &uevent_sock_list);
>  > - mutex_unlock(&uevent_sock_mutex);
>  > + /* Restrict uevents to initial user namespace. */
>  > + if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
>  > + mutex_lock(&uevent_sock_mutex);
>  > + list_add_tail(&ue_sk->list, &uevent_sock_list);
>  > + mutex_unlock(&uevent_sock_mutex);
>  > + }
>  > +
>  > return 0;
>  > }
>  > 
>  > @@ -713,9 +717,11 @@ static void uevent_net_exit(struct net *net)
>  > {
>  > struct uevent_sock *ue_sk = net->uevent_sock;
>  > 
>  > - mutex_lock(&uevent_sock_mutex);
>  > - list_del(&ue_sk->list);
>  > - mutex_unlock(&uevent_sock_mutex);
>  > + if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
>  > + mutex_lock(&uevent_sock_mutex);
>  > + list_del(&ue_sk->list);
>  > + mutex_unlock(&uevent_sock_mutex);
>  > + }
>  > 
>  > netlink_kernel_release(ue_sk->sk);
>  > kfree(ue_sk);

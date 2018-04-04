Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx4+PPUnF8FgwNUjfk3/is15NEFa9B4g6y38Iglc79HJzIKUZbkXY8PTfwFKsP/STG7Qr/4st
ARC-Seal: i=1; a=rsa-sha256; t=1522881552; cv=none;
        d=google.com; s=arc-20160816;
        b=g81BtJBFsXwuAUxNGN1Yy6BhCe80ZskwsNfy9vvUF+zZVKLfCsyVOOuCYTpRG4SYR8
         E/yF+KlF7lsL43AZEw474UIBllOf0T6lX3jjEwVjzTtnQRNVrCSgM1gwB69JFN1GkM9x
         BNW/VJfmD3mOkHaLB+j6JOP0+xhr4Xfm9vVvfp70QEMbe5f/dKoFZKtVITjGCxXUxoQo
         CwLqg5VxjqckfdoNK5z/OAMogsj0u5/fH6vzrfzZtkf72jyiStkUveutVjZSRE1xQiFv
         8EqPY5Obh8nbIAvGqkXs+yB2PlcurghtMPqwezoxwAH1Q0wVCNI5xhsjuI4ceXE/BnyV
         iawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=B5p10nvjNz1uhJppGkixhuxtFYnIuAgUXib6y0HmBNY=;
        b=Q+Hzm7DmFN6Ol3L+qhHeELlrJ3n+aYHOm2CvYI91sAGODiQl7+SBrNRvCk9j4e3VgY
         O2gpm0WSLlGtmK4bA7yfEiettb1KZ7CG17YIJH0s7tbL1a56GqHwgjvF/ZqUzXX06zsq
         q5xP/xqIXr+1R6J+330gUCvNvzqYHz0qEPbtKUutUuA/UhddYjCqcln5Sdrh1zzuxdoP
         7IjAvnIfWqxEdzVOwgEfwFTSNvS8dWMMM4mj515yvG9qexKBZ9BdCd+ANauJQQNVHcvv
         ukjhzQBdJHUZRji+XMEt+2ta8VtUo5cHj6iZBjK4J2a2Oad6at+VrFAziEhyf8nir7iy
         rmuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: davem@davemloft.net,  gregkh@linuxfoundation.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  ktkhai@virtuozzo.com,  serge@hallyn.com
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
	<20180404203048.GA21118@gmail.com>
Date: Wed, 04 Apr 2018 17:38:02 -0500
In-Reply-To: <20180404203048.GA21118@gmail.com> (Christian Brauner's message
	of "Wed, 4 Apr 2018 22:30:49 +0200")
Message-ID: <871sfuha2d.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3r3e-0000vY-2p;;;mid=<871sfuha2d.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18v4kKt4NfxzXZb+ADTLYvp8VNf3/ydzeM=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 322 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 2.3 (0.7%), b_tie_ro: 1.52 (0.5%), parse: 0.82 (0.3%),
	extract_message_metadata: 14 (4.3%), get_uri_detail_list: 2.5 (0.8%),
	tests_pri_-1000: 6 (1.7%), tests_pri_-950: 1.07 (0.3%), tests_pri_-900: 0.89
	(0.3%), tests_pri_-400: 31 (9.7%), check_bayes: 30 (9.4%), b_tokenize: 8
	(2.6%), b_tok_get_all: 8 (2.6%), b_comp_prob: 2.5 (0.8%), b_tok_touch_all: 9
	(2.7%), b_finish: 0.55 (0.2%), tests_pri_0: 257 (79.9%),
	check_dkim_signature: 0.52 (0.2%), check_dkim_adsp: 3.0 (0.9%),
	tests_pri_500: 6 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net] netns: filter uevents correctly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596857046747750386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

> On Wed, Apr 04, 2018 at 09:48:57PM +0200, Christian Brauner wrote:
>> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
>> 
>> enabled sending hotplug events into all network namespaces back in 2010.
>> Over time the set of uevents that get sent into all network namespaces has
>> shrunk. We have now reached the point where hotplug events for all devices
>> that carry a namespace tag are filtered according to that namespace.
>> 
>> Specifically, they are filtered whenever the namespace tag of the kobject
>> does not match the namespace tag of the netlink socket. One example are
>> network devices. Uevents for network devices only show up in the network
>> namespaces these devices are moved to or created in.
>> 
>> However, any uevent for a kobject that does not have a namespace tag
>> associated with it will not be filtered and we will *try* to broadcast it
>> into all network namespaces.
>> 
>> The original patchset was written in 2010 before user namespaces were a
>> thing. With the introduction of user namespaces sending out uevents became
>> partially isolated as they were filtered by user namespaces:
>> 
>> net/netlink/af_netlink.c:do_one_broadcast()
>> 
>> if (!net_eq(sock_net(sk), p->net)) {
>>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
>>                 return;
>> 
>>         if (!peernet_has_id(sock_net(sk), p->net))
>>                 return;
>> 
>>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>>                              CAP_NET_BROADCAST))
>>         j       return;
>> }
>> 
>> The file_ns_capable() check will check whether the caller had
>> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
>> namespace of interest. This check is fine in general but seems insufficient
>> to me when paired with uevents. The reason is that devices always belong to
>> the initial user namespace so uevents for kobjects that do not carry a
>> namespace tag should never be sent into another user namespace. This has
>> been the intention all along. But there's one case where this breaks,
>> namely if a new user namespace is created by root on the host and an
>> identity mapping is established between root on the host and root in the
>> new user namespace. Here's a reproducer:
>> 
>>  sudo unshare -U --map-root
>>  udevadm monitor -k
>>  # Now change to initial user namespace and e.g. do
>>  modprobe kvm
>>  # or
>>  rmmod kvm
>> 
>> will allow the non-initial user namespace to retrieve all uevents from the
>> host. This seems very anecdotal given that in the general case user
>> namespaces do not see any uevents and also can't really do anything useful
>> with them.
>> 
>> Additionally, it is now possible to send uevents from userspace. As such we
>> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
>> namespace of the network namespace of the netlink socket) userspace process
>> make a decision what uevents should be sent.
>> 
>> This makes me think that we should simply ensure that uevents for kobjects
>> that do not carry a namespace tag are *always* filtered by user namespace
>> in kobj_bcast_filter(). Specifically:
>> - If the owning user namespace of the uevent socket is not init_user_ns the
>>   event will always be filtered.
>> - If the network namespace the uevent socket belongs to was created in the
>>   initial user namespace but was opened from a non-initial user namespace
>>   the event will be filtered as well.
>> Put another way, uevents for kobjects not carrying a namespace tag are now
>> always only sent to the initial user namespace. The regression potential
>> for this is near to non-existent since user namespaces can't really do
>> anything with interesting devices.
>> 
>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>
> That was supposed to be [PATCH net] not [PATCH net-next] which is
> obviously closed. Sorry about that.

This does not appear to be a fix.
This looks like feature work.
The motivation appears to be that looks wrong let's change it.

So let's please leave this for when net-next opens again so we can
have time to fully consider a change in semantics.

Thank you,
Eric

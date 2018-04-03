Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbeDCCBi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:01:38 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:49119 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeDCCBg (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:2:1>);
        Mon, 2 Apr 2018 22:01:36 -0400
Message-Id: <5AC350F4020000F9000B342A@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 02 Apr 2018 20:01:24 -0600
From: "Gang He" <ghe@suse.com>
To: <teigland@redhat.com>
Cc: <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dlm: prompt the user SCTP is experimental
References: <1521528327-882-1-git-send-email-ghe@suse.com>
 <5AB4F2CC020000F9000B145C@prv-mh.provo.novell.com>
 <20180402150315.GA7980@redhat.com>
In-Reply-To: <20180402150315.GA7980@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,



>>> 
> On Thu, Mar 22, 2018 at 10:27:56PM -0600, Gang He wrote:
>> Hello David,
>> 
>> Do you agree to add this prompt to the user? 
>> Since sometimes customers attempted to setup SCTP protocol with two rings, 
>> but they could not get the expected result, then it maybe bring some 
> concerns to the customer for DLM qualities.
> 
> I don't think the kernel message is a good way to communicate this to users.
> Dave
OK, I got your point.
But, could we have a appropriate way to let the users know SCTP protocol status?

Thanks
Gang

> 
> 
>> > As you know, DLM module can use TCP or SCTP protocols to
>> > communicate among the cluster.
>> > But, according to our testing, SCTP protocol is still considered
>> > experimental, since not all aspects are working correctly and
>> > it is not full tested.
>> > e.g. SCTP connection channel switch needs about 5mins hang in case
>> > one connection(ring) is broken.
>> > Then, I suggest to add a kernel print, which prompts the user SCTP
>> > protocol for DLM should be considered experimental, it is not
>> > recommended in production environment.
>> > 
>> > Signed-off-by: Gang He <ghe@suse.com>
>> > ---
>> >  fs/dlm/lowcomms.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
>> > index cff79ea..18fd85d 100644
>> > --- a/fs/dlm/lowcomms.c
>> > +++ b/fs/dlm/lowcomms.c
>> > @@ -1307,6 +1307,7 @@ static int sctp_listen_for_all(void)
>> >  		return -ENOMEM;
>> >  
>> >  	log_print("Using SCTP for communications");
>> > +	log_print("SCTP protocol is experimental, use at your own risk");
>> >  
>> >  	result = sock_create_kern(&init_net, dlm_local_addr[0]->ss_family,
>> >  				  SOCK_STREAM, IPPROTO_SCTP, &sock);
>> > -- 
>> > 1.8.5.6

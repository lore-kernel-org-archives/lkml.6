Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeDBPDS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:03:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751247AbeDBPDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:03:17 -0400
Date: Mon, 2 Apr 2018 10:03:15 -0500
From: David Teigland <teigland@redhat.com>
To: Gang He <ghe@suse.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dlm: prompt the user SCTP is experimental
Message-ID: <20180402150315.GA7980@redhat.com>
References: <1521528327-882-1-git-send-email-ghe@suse.com>
 <5AB4F2CC020000F9000B145C@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AB4F2CC020000F9000B145C@prv-mh.provo.novell.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 10:27:56PM -0600, Gang He wrote:
> Hello David,
> 
> Do you agree to add this prompt to the user? 
> Since sometimes customers attempted to setup SCTP protocol with two rings, 
> but they could not get the expected result, then it maybe bring some concerns to the customer for DLM qualities.

I don't think the kernel message is a good way to communicate this to users.
Dave


> > As you know, DLM module can use TCP or SCTP protocols to
> > communicate among the cluster.
> > But, according to our testing, SCTP protocol is still considered
> > experimental, since not all aspects are working correctly and
> > it is not full tested.
> > e.g. SCTP connection channel switch needs about 5mins hang in case
> > one connection(ring) is broken.
> > Then, I suggest to add a kernel print, which prompts the user SCTP
> > protocol for DLM should be considered experimental, it is not
> > recommended in production environment.
> > 
> > Signed-off-by: Gang He <ghe@suse.com>
> > ---
> >  fs/dlm/lowcomms.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index cff79ea..18fd85d 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
> > @@ -1307,6 +1307,7 @@ static int sctp_listen_for_all(void)
> >  		return -ENOMEM;
> >  
> >  	log_print("Using SCTP for communications");
> > +	log_print("SCTP protocol is experimental, use at your own risk");
> >  
> >  	result = sock_create_kern(&init_net, dlm_local_addr[0]->ss_family,
> >  				  SOCK_STREAM, IPPROTO_SCTP, &sock);
> > -- 
> > 1.8.5.6

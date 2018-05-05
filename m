Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AB8JxZqOJlBTGmVGZCRB+Gwcce33qFcPq9glcD+9uklR/Q3WevGTXEUYSuur90dSnFqK5DF81nlo
ARC-Seal: i=1; a=rsa-sha256; t=1525523872; cv=none;
        d=google.com; s=arc-20160816;
        b=MSzW2D+e32feYRAy32eOa7wivSjCtSrbdX6Wc8s8LILfJhn2qoiRqYbIxAC7+OlAkv
         m3WMNWjrJ+5q3uuGi+zyOo3F/hjwAcWyZr4JvQAIWHamtt1zIYBWXa95y5TfAyD9k7Xk
         jBbtyUx8/nAtUL9Fe4sk3AFJNMRVdmLt4aLClH97iePTUMNssAjyjKNOdkFEa9XzRqem
         +HpR4TaGlf/L6jLHA5lgIQ4INamnidPMWO34Al8PDYGPzDeQMrZnsl2FhLwYxDp9eayp
         7sMH3SSinfxMZrxrYlM2k8QxV3/lY3s76+vljtpfr9ptOVuNZBM2CU3f5X0I/yxSvQ3O
         DQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=UIgi1ZMZMmHeL8fwWTW6uhY1FkW3BX7hL1HxPj13Aas=;
        b=leoyc4j4nKfnYTmCbdiGx0axgDk+bPT9U1aEgAQz8XkDMjdl54/wxKh5WHlPcekBoU
         v5t1xyGS+4ZwY9bEWgkhmSNGUnwcmt5F6cmalNdougmZQ+5xn380IdtKa7nA4AkZcyc2
         7ElK6AUO8zT1YsRdw3pF5mQ6XGr8fhD6+U1euaPWJ5kXOiD60RXAKVHwjDVyBPKplEkG
         kMlgMewpGntg8lIOnxLJiPKvwy5gw3/08ucE0vb3gtuoYUu+/LQSRy5okRB/voh9kr47
         7HMu36HgeGZx4wYFlAM40YINbt+hDAwriiCnOCGpvF842BAKfHBOMqUVFAL8Rwr/ce7z
         Ffzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,  Alexey Dobriyan <adobriyan@gmail.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jiri Slaby <jslaby@suse.com>,  Alessandro Zummo <a.zummo@towertech.it>,  Alexandre Belloni <alexandre.belloni@bootlin.com>,  linux-acpi@vger.kernel.org,  drbd-dev@lists.linbit.com,  linux-ide@vger.kernel.org,  netdev@vger.kernel.org,  linux-rtc@vger.kernel.org,  megaraidlinux.pdl@broadcom.com,  linux-scsi@vger.kernel.org,  devel@driverdev.osuosl.org,  linux-afs@lists.infradead.org,  linux-ext4@vger.kernel.org,  jfs-discussion@lists.sourceforge.net,  netfilter-devel@vger.kernel.org,  linux-kernel@vger.kernel.org
References: <20180425154827.32251-1-hch@lst.de>
	<20180425154827.32251-12-hch@lst.de>
Date: Sat, 05 May 2018 07:37:33 -0500
In-Reply-To: <20180425154827.32251-12-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 25 Apr 2018 17:47:58 +0200")
Message-ID: <878t8y46sy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEwRa-0008NI-Fi;;;mid=<878t8y46sy.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+u9U/hzyYnKrljAN7VH4B4tp3ugbXxXP4=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 257 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 2.9 (1.1%), b_tie_ro: 1.94 (0.8%), parse: 0.81 (0.3%),
	extract_message_metadata: 10 (4.0%), get_uri_detail_list: 1.59 (0.6%),
	tests_pri_-1000: 5 (2.1%), tests_pri_-950: 1.17 (0.5%), tests_pri_-900: 1.00
	(0.4%), tests_pri_-400: 25 (9.5%), check_bayes: 24 (9.1%), b_tokenize: 9
	(3.4%), b_tok_get_all: 7 (2.8%), b_comp_prob: 2.1 (0.8%), b_tok_touch_all:
	3.6 (1.4%), b_finish: 0.55 (0.2%), tests_pri_0: 205 (79.5%),
	check_dkim_signature: 0.63 (0.2%), check_dkim_adsp: 2.5 (1.0%),
	tests_pri_500: 3.9 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 11/40] ipv6/flowlabel: simplify pid namespace lookup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598733816436196024?=
X-GMAIL-MSGID: =?utf-8?q?1599627719391539099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> The shole seq_file sequence already operates under a single RCU lock pair,
> so move the pid namespace lookup into it, and stop grabbing a reference
> and remove all kinds of boilerplate code.

This is wrong.

Move task_active_pid_ns(current) from open to seq_start actually means
that the results if you pass this proc file between callers the results
will change.  So this breaks file descriptor passing.

Open is a bad place to access current.  In the middle of read/write is
broken.


In this particular instance looking up the pid namespace with
task_active_pid_ns was a personal brain fart.  What the code should be
doing (with an appropriate helper) is:

struct pid_namespace *pid_ns = inode->i_sb->s_fs_info;

Because each mount of proc is bound to a pid namespace.  Looking up the
pid namespace from the super_block is a much better way to go.

Eric



> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  net/ipv6/ip6_flowlabel.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
>
> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index c05c4e82a7ca..a9f221d45ef9 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -754,7 +754,10 @@ static struct ip6_flowlabel *ip6fl_get_idx(struct seq_file *seq, loff_t pos)
>  static void *ip6fl_seq_start(struct seq_file *seq, loff_t *pos)
>  	__acquires(RCU)
>  {
> +	struct ip6fl_iter_state *state = ip6fl_seq_private(seq);
> +
>  	rcu_read_lock_bh();
> +	state->pid_ns = task_active_pid_ns(current);
>  	return *pos ? ip6fl_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
>  }
>  
> @@ -810,36 +813,15 @@ static const struct seq_operations ip6fl_seq_ops = {
>  
>  static int ip6fl_seq_open(struct inode *inode, struct file *file)
>  {
> -	struct seq_file *seq;
> -	struct ip6fl_iter_state *state;
> -	int err;
> -
> -	err = seq_open_net(inode, file, &ip6fl_seq_ops,
> +	return seq_open_net(inode, file, &ip6fl_seq_ops,
>  			   sizeof(struct ip6fl_iter_state));
> -
> -	if (!err) {
> -		seq = file->private_data;
> -		state = ip6fl_seq_private(seq);
> -		rcu_read_lock();
> -		state->pid_ns = get_pid_ns(task_active_pid_ns(current));
> -		rcu_read_unlock();
> -	}
> -	return err;
> -}
> -
> -static int ip6fl_seq_release(struct inode *inode, struct file *file)
> -{
> -	struct seq_file *seq = file->private_data;
> -	struct ip6fl_iter_state *state = ip6fl_seq_private(seq);
> -	put_pid_ns(state->pid_ns);
> -	return seq_release_net(inode, file);
>  }
>  
>  static const struct file_operations ip6fl_seq_fops = {
>  	.open		=	ip6fl_seq_open,
>  	.read		=	seq_read,
>  	.llseek		=	seq_lseek,
> -	.release	=	ip6fl_seq_release,
> +	.release	=	seq_release_net,
>  };
>  
>  static int __net_init ip6_flowlabel_proc_init(struct net *net)

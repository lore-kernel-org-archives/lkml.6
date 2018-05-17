Return-Path: <oneukum@suse.com>
X-Google-Smtp-Source: AB8JxZpP1QQdZVaGahlt275tLfPXUdqy93todW5lu/kv5PB8hv7BqqfIv4pL5WR6j/9EjumuoScG
ARC-Seal: i=1; a=rsa-sha256; t=1526562312; cv=none;
        d=google.com; s=arc-20160816;
        b=BfttOleQ43GWKWPxHbpxvVdCAHhmt0EWlMn+kTipZT8IlKhnkW9sw0Pcs24f/pe9FB
         N3355poro5oq7S2xmF6xXeOvlMvr+BdiNGge/LcAQaM/hdOEiy39Wr5Zj0ZSmVEvZZHb
         o9viPs3PFscmNxXMRjHM8arpJW9WjM7BpoLba7X3K5eR+5qUJxt716i24hA9Tu86h8gW
         xssScduH2CFPmKH+F3YZagNtOhYr9uYmoZ4Oj2VQgUWtGe/4hzRDJFTLCdQ7fpsAlXqU
         uPmCDDdT08y6eBaiw9KvFElzja863qlwEu/VtSyIs5PIf6Ar+Q7LPAfxclCg4WhvkaBM
         rQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:date:cc:to:from:subject
         :message-id:arc-authentication-results;
        bh=KIbJEiIxNLXpz4jtHFrORV2NewYlh7AWbD8qcAh1Iko=;
        b=pM8mxi3nOmunn22YXrkXZZnJydlpmyqiwQsiXkabxFDKUY55L1D7qJ2omTXg5KOvWG
         t3WJZ5z8eY3NIY7MvFSKo3KznYoBPVLkXNGLR0btn0YhbWfKIkHuSc5yeh5NLqF7fflr
         n1x0P3fOnn0r0jfuzOhyMGh9KK59Id58LOQ9Jvn61vGm/Cln9F7HhtbtxQsEFMKHlW5D
         OfEOt1vd6z7vNkaTwvotcRvtBuh3/Xd7uqAqMO3GHZt3MbQezEiIbIpWz/6794YWyIjy
         5wTzhoXbN3zeC0ywq7ZQ4nUyk4B9mccIJme4d3JfNa1hn74HfI0WWPJsRQmwIfLalA70
         Revg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Message-ID: <1526561908.15506.5.camel@suse.com>
Subject: Re: [PATCH] usb-storage: Add quirks to make G-Technology "G-Drive"
 work
From: Oliver Neukum <oneukum@suse.com>
To: Alexander Kappner <agk@godking.net>, Alan Stern
 <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date: Thu, 17 May 2018 14:58:28 +0200
In-Reply-To: <9c638d96-d2b4-cf19-d7e8-4ef93549bd79@godking.net>
References: <Pine.LNX.4.44L0.1805161647330.1604-100000@iolanthe.rowland.org>
	 <9c638d96-d2b4-cf19-d7e8-4ef93549bd79@godking.net>
Content-Type: multipart/mixed; boundary="=-h7qlglWApRe8X3b59KHS"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600652190805149775?=
X-GMAIL-MSGID: =?utf-8?q?1600716603652979698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-h7qlglWApRe8X3b59KHS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Donnerstag, den 17.05.2018, 01:15 -0700 schrieb Alexander Kappner:
> Yes. Without this flag, the device keeps throwing similar errors on 
> usb-storage. That's the same result I get on a host that doesn't have UAS 
> compiled in. Here's a dmesg:

Hi,

this is suspicious. You do not actually whether US_FL_NO_WP_DETECT
by itself would make the device work. Can you please test that?
You will need the attached patch for the quirk to be supported.

	Regards
		Oliver

--=-h7qlglWApRe8X3b59KHS
Content-Disposition: attachment;
	filename="0001-UAS-add-support-for-the-quirk-US_FL_NO_WP_DETECT.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-UAS-add-support-for-the-quirk-US_FL_NO_WP_DETECT.patch";
	charset="UTF-8"

RnJvbSAxZmY2YzljOWNjNjZkZGI0Y2Y3Y2E5NWJlYTU4OWQ2YTMwYzYzNjIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBUaHUsIDE3IE1heSAyMDE4IDE0OjQ2OjQ3ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gVUFTOiBh
ZGQgc3VwcG9ydCBmb3IgdGhlIHF1aXJrIFVTX0ZMX05PX1dQX0RFVEVDVAoKVGhlIGFzc3VtcHRp
b24gdGhhdCB0aGlzIHF1aXJrIGNhbiBiZSBsaW1pdGVkIHRvIG9sZCBzdG9yYWdlCmRldmljZXMg
d2FzIHRvbyBvcHRpbWlzdGljLgoKU2lnbmVkLW9mZi1ieTogT2xpdmVyIE5ldWt1bSA8b25ldWt1
bUBzdXNlLmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9zdG9yYWdlL3Vhcy5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Ivc3Rv
cmFnZS91YXMuYyBiL2RyaXZlcnMvdXNiL3N0b3JhZ2UvdWFzLmMKaW5kZXggNjAzNGMzOWI2N2Qx
Li43ZWU2N2U4YzFmMWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL3N0b3JhZ2UvdWFzLmMKKysr
IGIvZHJpdmVycy91c2Ivc3RvcmFnZS91YXMuYwpAQCAtODM2LDYgKzgzNiwxMCBAQCBzdGF0aWMg
aW50IHVhc19zbGF2ZV9jb25maWd1cmUoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2KQogCWlmIChk
ZXZpbmZvLT5mbGFncyAmIFVTX0ZMX0JST0tFTl9GVUEpCiAJCXNkZXYtPmJyb2tlbl9mdWEgPSAx
OwogCisJLyogVUFTIGFsc28gbmVlZHMgdG8gc3VwcG9ydCBGTF9OT19XUF9ERVRFQ1QgKi8KKwlp
ZiAoZGV2aW5mby0+ZmxhZ3MgJiBVU19GTF9OT19XUF9ERVRFQ1QpCisJCXNkZXYtPnNraXBfbXNf
cGFnZV8zZiA9IDE7CisKIAlzY3NpX2NoYW5nZV9xdWV1ZV9kZXB0aChzZGV2LCBkZXZpbmZvLT5x
ZGVwdGggLSAyKTsKIAlyZXR1cm4gMDsKIH0KLS0gCjIuMTMuNgoK


--=-h7qlglWApRe8X3b59KHS--

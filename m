Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AIpwx4+s54J9ed0HqLvRF+xtnpAKn1LdPv5uIpzVrClIZWCRzrexznxdY6vvJHdfwdD3DriktZog
ARC-Seal: i=1; a=rsa-sha256; t=1523428796; cv=none;
        d=google.com; s=arc-20160816;
        b=gYHhBh61joOfoLqGsQpJmaRifQh5p7K4yZbyZxxO/cpt4Dw8nOyG4ntGu/QCuRHSqm
         TwEMEo28GgmFxw0WL1fo4YwR6TinOXzvWpPLdRpnnRFWsrtj2Azz2z56AFT3EMgN2dqI
         cSvyTSyAZdiJKl4QADTHQXk22OtAQXxyvZqdRC4BMqZ7PZmHHNfffutXJGQ196HuwlkA
         fK5V5GFwpNlAgF8iNRycrt5NwbEGbioUGWWtXrF5qVBdFNI6jbW4sJTnhIU//dWYtNGw
         hZ9M0NagLdjuRNUt+MdFtQZ+92yzlQjCiqiZzDkXdRg8d/zGeNiUGYi0EKLJsuN2DTcg
         F2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ZPxv/JuWuFKx6QsUsekIgXrilOzCS+s43+vDuXKs2cE=;
        b=0v/KtIcBbivGLAtQfnsVZTsiA53/pUhXBjebdOVcqdTTTXUsI/t9pLPajl7+pU85J6
         6EeLmdyo+DDrAqZ+CtW75GhW3y2UNaBEQWumQbh8iUkkbJdxXuq51YJksqUxGQHav3rd
         JG9/+iJM9WiTLX/Tcu+LGFXtt1RSLIcSrC+NL3rThGSdmoNqXw+hSF/IVBOlgOvYI0DI
         ZzVeh1n0BdcKkD1b2v4Cov0jr8xeHhz8n+W1xBVZclEU898Ml9SFMSsY+PUqhTLf9o8h
         1ehUeEDcKtzOj+U71+gHe9B0e4KyjDgexkBhN/fshsBVyl7orLf21vcfu0jUnS9dpq1L
         vN6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Wed, 11 Apr 2018 07:39:46 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>, Kyle Spiers <ksspiers@google.com>,
	Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
	David Howells <dhowells@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] isofs compress: Remove VLA usage
Message-ID: <20180411063946.GP30522@ZenIV.linux.org.uk>
References: <20180410234532.185426-1-ksspiers@google.com>
 <20180411003331.GM30522@ZenIV.linux.org.uk>
 <CAGXu5jJBqiXZzvRaoXRVuxFckaFJq+LfM227t2uXF3vhwE7WPg@mail.gmail.com>
 <15d2961566261c1b9428402930fd3f994c7f472d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d2961566261c1b9428402930fd3f994c7f472d.camel@perches.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597404821961766971?=
X-GMAIL-MSGID: =?utf-8?q?1597430874109466780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:15:28PM -0700, Joe Perches wrote:
> On Tue, 2018-04-10 at 17:51 -0700, Kees Cook wrote:
> > On Tue, Apr 10, 2018 at 5:33 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > On Tue, Apr 10, 2018 at 04:45:32PM -0700, Kyle Spiers wrote:
> > > > As part of the effort to remove VLAs from the kernel[1], this changes
> > > > the allocation of the bhs and pages arrays from being on the stack to being
> > > > kcalloc()ed. This also allows for the removal of the explicit zeroing
> > > > of bhs.
> > > > 
> > > > https://lkml.org/lkml/2018/3/7/621
> > > 
> > > Do you even bother reading the feedback given to such patches?  I'm just
> > > curious,
> > 
> > He made a tool mistake (sent v2 again) -- please see v4.
> 
> No worries but Kyle didn't just mistakenly resend v2.
> It was a v3 with a different below the dashes changelog.
> 
> Kyle, it would be good if next time you were to add a
> listing of changes in each revision below the dashes.

Shit happens...

Al, fully expecting to discover having made something spectacularly bonehead
2 minutes after sending a patch out - happens often enough.

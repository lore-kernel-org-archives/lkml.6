Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx49gmMEjb6/ItKsEziGu+3XEd3wdIoGmY5dK1IuMvGVzCR602XU/SNnnW0F/3XxC9LlDPwWe
ARC-Seal: i=1; a=rsa-sha256; t=1524478341; cv=none;
        d=google.com; s=arc-20160816;
        b=CyZOAN7o1z7CwSs6cU6nAqnrGHG633RrYmpB5aAK8kBjIqeF8TY5iEFXSAHIchBPYQ
         iNOfNtj34POX9P5fIfx134w9fi0xc2D03jGzJHASJj0shoajPShLEGZJebioZwLLrWxd
         OpQmhoVqetJDfWEKLZ7AE7mybL+UUzJfwm5pJ+WfEWqo6soqrG9XPMYq0UJUwrZ6Mbtv
         L5OTFco3U2t0nCKYT/HBMhL60x/MxR4NjOQNgf+XnKkpT1rIREA8dTqwYO1E2GhpGyqu
         YE2XD+WgRq0/SmV8I+TLas5FL29+31CciiIBNOjwNqB8VZuFqByQIIu6+Dk5wXqOIF/x
         DDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=MwRgql5mm3+eaeSbeWbWvGgcZ50ASz1ung2e67njjEs=;
        b=giW04gks5CaNeHdvLi9qRebL6jFd97Lhkci5Me1Jn+HWdrKFyf4vpMwQzdghche4l4
         2NzHz/7YvtEgERvluRnb1FQlziKcYgdG/n+AoRh2Fnb6BvDWH1Fx6C7BPrsc8JxOo2uN
         cAwzo/qu52zZzP9mQ+CYwHxLrgc8mFHHnD+AX6Ci2kncckPmP4mLNpA5Z1IUyodHXgDZ
         CsR1WqwyZtf+l6ZjLMWVo2aC7NRcPNXmZvu2FZv7NKindhN77hbJvoeNXdqijLxtc/NW
         ZMGk6WUXS8JXGN0sfCaC8hSlUHt0Z43QcS5aYpOhIkOekdR3IZWNqVJJGEdI9rdG3Y7L
         B7nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 23 Apr 2018 12:12:18 +0200
To: kbuild-all@01.org
Cc: ebiederm@xmission.com, davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 2/2] netns: isolate seqnums to use per-netns
 locks
Message-ID: <20180423101217.GA6903@gmail.com>
References: <20180418152106.18519-3-christian.brauner@ubuntu.com>
 <201804231003.izXFVWTI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201804231003.izXFVWTI%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598097857058546891?=
X-GMAIL-MSGID: =?utf-8?q?1598531401510711995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:39:50AM +0800, kbuild test robot wrote:
> Hi Christian,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on net-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Christian-Brauner/netns-uevent-performance-tweaks/20180420-013717
> config: alpha-alldefconfig (attached as .config)
> compiler: alpha-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=alpha 
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/ksysfs.o: In function `uevent_seqnum_show':
> >> (.text+0x18c): undefined reference to `get_ns_uevent_seqnum_by_vpid'
>    (.text+0x19c): undefined reference to `get_ns_uevent_seqnum_by_vpid'

Right, this happens when CONFIG_NET=n. I am about to send out the second
version of the patch that includes all of the test results in the commit
message and also accounts for kernels compiled without CONFIG_NET.

Thanks!
Christian

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-35865-1521382979-2-17544385978631799948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='ID'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521382979; b=Zc41qQZgn6j51hunfdbTaNZquT2tazuf/+1bRvESsYWHgzO
    Wy1dEJzfph951Nr+cFS8QCSIs7PFtGsfFD1CF3VL/bltTHrdCA3O1524F3Z5eeH3
    T1f/4+UIRSJsCAQ7oj5r/XUmUBGrn3vV76OlH994FnnKpReNVzwy5lm+P4fum7sz
    zpxvyWeoIQP88olirzDYuUJt/9D0hLo0/Jk57g8f5nJdgJfPcGq6ohgdx7uVzotc
    Vlh3TYrZwMIMtuDDXrTUE2XtsPtnt+R9S3WZ7Ayofcya8bYEADXcKX+KecnPG9ud
    nQDn4qH0p3G+qGHraSBF1pZ7M8bWSyPpNcQu94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521382979; bh=hf+Ch3GTzih5S9ovmxX5FT2itD
    +Ooe5Y5hjCDyGT4GA=; b=lxFClOpvJ3wzzf3vzLZlCRT0CTX3WOEVl/vip0sVY1
    Wj7V7DgLfsQOA+Cj3fF1jd22ZbzyAsyw4Na9Zz/2xgTBJUVv0f9JhQ/gRX6R4aFL
    ZGF/ogtK8Dt17X5WHuV5Q8azSbqBqBKvBIU8jo44mG+hFyoBw6q0DA57b6KVBuRN
    qN+/lcJqP5/W1oJxGc3Tf68Z9OGZMzabSTlRe2nf4Ywf6PxLBQMmiChco5ZZ+1uy
    Hx3V8TMOE/QRjD6TFwYbd+IFShLw2ub4vmPrEIjHZH2Y+DSASXDaFM7WjJYZAX+j
    6nqOgUGuJD+HvQt/eencsp99HfAj4Z4tlJNPQkvh6Ckw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=caviumnetworks.onmicrosoft.com header.i=@caviumnetworks.onmicrosoft.com header.b=Cox3bynz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=caviumnetworks.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=caviumnetworks.onmicrosoft.com header.i=@caviumnetworks.onmicrosoft.com header.b=Cox3bynz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=caviumnetworks.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeCROWx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 10:22:53 -0400
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com ([104.47.33.51]:45600
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754143AbeCROWv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 18 Mar 2018 10:22:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Sun, 18 Mar 2018 17:22:30 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Tejun Heo <tj@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 06/13] task_isolation: userspace hard isolation from
 kernel
Message-ID: <20180318142230.7vcvayiktypqqy7s@yury-thinkpad>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
 <1509728692-10460-7-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509728692-10460-7-git-send-email-cmetcalf@mellanox.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [36.85.197.25]
X-ClientProxiedBy: VI1PR08CA0132.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::34) To CY4PR07MB2904.namprd07.prod.outlook.com
 (2603:10b6:903:26::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ea02f1-1844-4125-442a-08d58cdbb92f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2904;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;3:YSsONbGxjkKQTEyiUC8nw5Tcl0BNLUlVEvr188Qy4CjmW4zoq2vxKrGvkvn37c5+mfrFmb1+g07AxiqYYrJXH9p7U3Ggv4HNJKcIppSxblQX7KY35c1bKmzX3tj1fxJ0NbCPW8zHM0y8jdMzK02WqCe1ouzt2U1SfUazrCL1tzD/y2WCrGrb88CKz+faZV8sdfHVJy5JAfH97e2Z7BxNhyDmZ5sIL6Nnk1ht3e89vqHtxxmSsua5MKcGNgJTPYaU;25:8NZR4OIc7p5pul0cUZzi03ApvSAblUuG25q26Z2A72sm48K3vhjuT3xMLek9CSvIWf/kL4H0x3gVIEvJI0sDmXCaaUPDW2JzbQkVWEwn9UX+8UYPlN5AOmI224HdZemByIOBNV1HOk2Dg5sg5/D6P+6qS8LnO3Nq3gCZOZCgCjBEl/Fd9xb/mztI4Lz68CE0L7WNqMUtPx6XPpF693xHyNrcasUg5Sc1zGCgPpj24ZFomBtaJw1JMLH7GpM4VgpU03imTcz05HR9TyKyYzQAAjzvk818Fbg4fK8VDUYfFpFckIlswRGX++4PABLAKCd6IkgFs9NpxHkLmo2kPevmvA==;31:E2Y5heIIJt4zp8nF9i0ldHSgIBaL0Z+Xn6EPFBVwv6tuqyCjm7oZ0B8MYJwE9Babm8qfjoWrzw537Du4bgx7qhPyIbOGeFJS/viASn3YRjkf7pwKg6vjyFXLPIdyrLPiVDx4bUBBdXMoH7jXVll2jjwfOSw5z0wA+1nOMPUETOmMTYn1UzAEUxyqAcg+8IKrLVkUtSgrrhH8wp/dL6R00Rmd5vpsZG63koVKcVaI+zk=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2904:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;20:KHQiToLMDSwAo9hU7tza6ugv08IVmF8J3HKVpJF3jHW8ADjQDbmd5UIRMcrsTMPve4jVZRK/jtUduYqIGJ5OfLdeA9EnkTmoNpAauicpKGITHLmjCW8oP1HxlLILNksb/MtyQAO4biP+HFd+maA5akb8kuzECPti82BF51qLoiq3x+MJ2SA21PmPcT+tFPW40S9ATICBXbR8Ydt3ZatzLZtU1e20/Wp9WSXkesoL1YQkMPal5Ev+9yv1+aDmbAjB+jeZps9JuIBV0NODEQ0QlIwYIkcxkl+8LUCdVqUWcwI4VWlMWxlW8k5IP6nE8RIrTjImM63jO6y+GrHK2AuKkqoGI/BhctbIjWLoYkG+lFfrrPHOc9VCf4I9LT6glNpWTnXsdvqNtkyC0SxDbWAi9vpmJK8jDt6iaG8eyJcK2LGPp9uoaw56k3tlxDZej+dAcSvIVuX47jsJNy69kpzFV9pJJUNw43/F5CsVKLjcDS7WmADG/Pe5TQaD6EPF7Fd122PHj1HFMi6Wjp+KNLvWW/it1tsucACup4uQS2HN0A7uwydKF//JokOyzUafFXHgWedofzbwWdl+RakP/BZBk3ev1DcTUo/ahcCCjKOtATo=
X-Microsoft-Antispam-PRVS: <CY4PR07MB29047AA7246C2F63415E1827E3D50@CY4PR07MB2904.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(211171220733660)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR07MB2904;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2904;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;4:5aK4IkvlkgAXs7kQUDRLXKMk8rLShpIYGrjF1RsTxEQj8UvXZ+URxUGgHlnIEvWRXSQsq9Yh62itnvgntwkrFBwXLbiSEC2V5v9WPr44EuZpTPjUk3r170lZE7kdaQTJdIrQj9+yd7zkv8tqVhOjAVZpHgjIG+Zg34EqsM6A9bMQAqi5aHntQA2/nHOKOPEsyBze52OkVDOtJ7wp+wavfjLn6isxqmpe11RAUriCd17dbvrzyQsBaNmcyB427DH6KAe6huj9gfx1x/Hpqj0DWBVQy4+t23XM+u6Iep5rW0104d6buetiBudH6fk9zg8WHttRNSXQ09zjySpSSh/QykzZcPkG+R7vh9GMn6lgqs21ykKlBGzlDWROXCuF8pGa
X-Forefront-PRVS: 06157D541C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(376002)(39850400004)(346002)(39380400002)(396003)(366004)(189003)(199004)(6246003)(52116002)(305945005)(25786009)(2950100002)(6496006)(59450400001)(55236004)(6666003)(4326008)(39060400002)(8676002)(6916009)(81156014)(76176011)(106356001)(58126008)(16586007)(316002)(47776003)(66066001)(478600001)(229853002)(6486002)(16526019)(9686003)(26005)(53936002)(72206003)(386003)(186003)(50466002)(8936002)(7736002)(76506005)(42882007)(2906002)(5660300001)(97736004)(105586002)(54906003)(23726003)(1076002)(6116002)(33896004)(81166006)(3846002)(68736007)(7416002)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2904;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2904;23:vtRXahnoj5SuBybpEGocjli8xp5KLUULAF5o1y/Rf?=
 =?us-ascii?Q?LsRZJaKf3tkWc/Iygof+wwtNsP8XwPpGgQ3MUG5lF7/DHQES0Xd7B5G6jQ4i?=
 =?us-ascii?Q?+d8mRcfnpH4+YmKEW9/bg2IlCygnly1YzdTJgvnHcTqeWpU0RIQ7nBlSzrDo?=
 =?us-ascii?Q?pBVPJjBhXabw4Pba60xMDNOmUt84ma0KhBqy5pAI6SZSgX7dhr6908vnps2q?=
 =?us-ascii?Q?E10nzrqGHSXDtOYjMDMMJzqpeN9JioX9+anW7tZrLI3zEpMQio1WMJ2D6Dsm?=
 =?us-ascii?Q?TvLtKqfehMuDjYqRzWnQCW1qsSADZt4ODNkt7uyaDuGXek4FY5dy8hXw3/0A?=
 =?us-ascii?Q?ODBJdIxUwn3WX0yHSeLDvhV7a4bqqzIgq/QDBgwQJ33eo9FDGNWbOxE+IFNK?=
 =?us-ascii?Q?nRPKTGNaQlef4IPxvxW7pWT4bRslS2kozthqz9zAFc9vaNx27/8aGahvo8c9?=
 =?us-ascii?Q?i+2enh7jbxDPO4xopktsIwVI0ZCir/uswFy22BkFAh7BU+d+qXu63PXlOsaM?=
 =?us-ascii?Q?QuXopNF0bgsaO6twRWlqVFH3EY1Kc88JWioP9OgtebzTTNjpnI3CYz7hKpUF?=
 =?us-ascii?Q?gTMtvVXnH74KkUd1QrwDPo080wjM9AP7N0OC1F5KWvlSyLoS4v7ijr4qVxFJ?=
 =?us-ascii?Q?o+XNSlEbgrxGxk7INuLdTO5Rw2auoEZttI/x2GDemOB5vyw8u/6waMQ4YYNn?=
 =?us-ascii?Q?fUmlX4s4NLcbC36Xpg1vM0PcHKB8KFf/aGM8Y/ueUqrRw+1+gxtObgwUfpDa?=
 =?us-ascii?Q?sDI8aeAPRduVMa/nzdjQ3Rm+TnJ1H+tjLDKkF/9jZ3swUb69w3ERedtfQT1p?=
 =?us-ascii?Q?Kfq7x+IRmVMloAl39510vQdy9E9wtyTnDcAB5oOSi+muKvYHmwwEs4eilcNw?=
 =?us-ascii?Q?1gIpjook36UNkEkD5QnqqdnfGJYKWqnZf730FmbIlMQyAnuoXoj7FBHIY8gy?=
 =?us-ascii?Q?jRI585r14BVHoONnU0Ex97n0XjBafhQDqQxt5jbp6eb3AxMn1kp+EfnbN9Wp?=
 =?us-ascii?Q?Xb2RCC2FOxzADw+SL1Gn/+lTzj22Ts50Oq02U+VukQagnrG90O5LCGe9pBo/?=
 =?us-ascii?Q?7zL0e4dgN9akU1/Ix8w2YmlChUFD6QzT3T63hKzEPPXcD+7D6iPmBTgKkMCF?=
 =?us-ascii?Q?YYLk4DNfUOgYb12EgKHo6KeabB3t+w4HJ0c889POVEqnVCGnyDvZAb4nJooK?=
 =?us-ascii?Q?QWDlwqfgQIKobz0AFfYDKuzCEX6LCbSzOzx8g0h5nH52Ohnu0CELm0a4YSiu?=
 =?us-ascii?Q?Dsk7sGI5MsIoQqPKsYTD1cyUWOzdPD52A3N8defhP4gELqKrxwuwEjnbMtdV?=
 =?us-ascii?Q?pbLRUQAVERqMn3NaNtBi9JLPzy16B3KlZCh+vbNjjH/d40hpay0K2n5JcVAo?=
 =?us-ascii?Q?bVMqw=3D=3D?=
X-Microsoft-Antispam-Message-Info: NOWef3BorzlnXgHO7IcvKNzE+bvgUcBrpo0d5l+JCfCp/6fgyvFRrsOcbfTTN6/BdGvYzyVhhb8k+lyXkQtdUkshpMkaFL+FB1dcHymjz/zn4tEGf4SBxpkzhB7RZ7j6PkFpxX2ERNHV8V0Ta9q9xcTvC6mCpMS6rHNO+doONjo+e7TtpdZe8jqTeOLgqMNa
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;6:pO1lUrU1avFx9IrYBtBsSWRIoOtOLjQURE5GKxatyvTnp6qUwrEB6kQL6/dHH7G/2RG97LnLyeWNDgckix+aNdg2v+M9Zu5H99B5H9oUpp6gB75dw9eFZUZGFOieGnjg6pZHI6Xka0u+1Svy3CBqaM5TiIHpxGs1W8p9d3HOIqxazVEHFDSWh8rH6embso7scJPEM030/rhtlGmM6ZHOe8WB8m9tXqg9MQVXnPHtZYhRLf77WjCW0R+dXZPRDTD96d8fOu5eSM4d/2vmW5nNWKrrS2FjCQLYihvauxDtIgwnl7vpysKJQN5RtxUTO4dUNInB1wqbwzE6M400fBcT6CVZV23s5qr7sj0uaZwuW8o=;5:etUW6vSqbwwV2r+OsBtkND6vt9Y3IFvTAgQPKWKTDBni7XlgZh1h2+9OAyYZt4FSEyPP/nrgmYqsrZY81eA1G+7/a9316DzUwt9m1IamkHLLfv2IsKTN5+kPyqHKZUhiK8vmFwMZKP0+HGL83Cv4Yy+ogQY4bhVUpG1maBePkAU=;24:LFwDEvPfVBOf9jPNN5ElG2Z56DnOI+HbtNm5JO1z4UnoLj0QjqriEQtpCKa0IIu3ghvTm3DY98SEKF2fn4aL4G/Y8FdeWeRjkV30+SX7gc4=;7:ukr3CjxZ4pP55PSZ2qULK7tn+cKJp1SbgX1nRtKWC13R5r0/khGe9fuaT3VyWSmytO+AcVI6SLOAm41VKtrh9OwB150I1ba8UQpRpIuTGfmNwEbHGH7HMmzKvm+mwgBIcSIhNQRxLhenHlUm/yxmX2izeuDRXOc/YkBhX4tqjDBW2vydtNyS1DG4okzB+xfoo9QaiKFwx/SdOydRGvut8NxGNBjlFybEHZNX+CQKPPzdxlnMcMcnqgIbn6Ihgi3f
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2018 14:22:45.3058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ea02f1-1844-4125-442a-08d58cdbb92f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2904
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Chris,

On Fri, Nov 03, 2017 at 01:04:45PM -0400, Chris Metcalf wrote:
> The existing nohz_full mode is designed as a "soft" isolation mode
> that makes tradeoffs to minimize userspace interruptions while
> still attempting to avoid overheads in the kernel entry/exit path,
> to provide 100% kernel semantics, etc.
> 
> However, some applications require a "hard" commitment from the
> kernel to avoid interruptions, in particular userspace device driver
> style applications, such as high-speed networking code.
> 
> This change introduces a framework to allow applications
> to elect to have the "hard" semantics as needed, specifying
> prctl(PR_TASK_ISOLATION, PR_TASK_ISOLATION_ENABLE) to do so.
> 
> The kernel must be built with the new TASK_ISOLATION Kconfig flag
> to enable this mode, and the kernel booted with an appropriate
> "nohz_full=CPULIST isolcpus=CPULIST" boot argument to enable
> nohz_full and isolcpus.  The "task_isolation" state is then indicated
> by setting a new task struct field, task_isolation_flag, to the
> value passed by prctl(), and also setting a TIF_TASK_ISOLATION
> bit in the thread_info flags.  When the kernel is returning to
> userspace from the prctl() call and sees TIF_TASK_ISOLATION set,
> it calls the new task_isolation_start() routine to arrange for
> the task to avoid being interrupted in the future.
> 
> With interrupts disabled, task_isolation_start() ensures that kernel
> subsystems that might cause a future interrupt are quiesced.  If it
> doesn't succeed, it adjusts the syscall return value to indicate that
> fact, and userspace can retry as desired.  In addition to stopping
> the scheduler tick, the code takes any actions that might avoid
> a future interrupt to the core, such as a worker thread being
> scheduled that could be quiesced now (e.g. the vmstat worker)
> or a future IPI to the core to clean up some state that could be
> cleaned up now (e.g. the mm lru per-cpu cache).
> 
> Once the task has returned to userspace after issuing the prctl(),
> if it enters the kernel again via system call, page fault, or any
> other exception or irq, the kernel will kill it with SIGKILL.
> In addition to sending a signal, the code supports a kernel
> command-line "task_isolation_debug" flag which causes a stack
> backtrace to be generated whenever a task loses isolation.
> 
> To allow the state to be entered and exited, the syscall checking
> test ignores the prctl(PR_TASK_ISOLATION) syscall so that we can
> clear the bit again later, and ignores exit/exit_group to allow
> exiting the task without a pointless signal being delivered.
> 
> The prctl() API allows for specifying a signal number to use instead
> of the default SIGKILL, to allow for catching the notification
> signal; for example, in a production environment, it might be
> helpful to log information to the application logging mechanism
> before exiting.  Or, the signal handler might choose to reset the
> program counter back to the code segment intended to be run isolated
> via prctl() to continue execution.
> 
> In a number of cases we can tell on a remote cpu that we are
> going to be interrupting the cpu, e.g. via an IPI or a TLB flush.
> In that case we generate the diagnostic (and optional stack dump)
> on the remote core to be able to deliver better diagnostics.
> If the interrupt is not something caught by Linux (e.g. a
> hypervisor interrupt) we can also request a reschedule IPI to
> be sent to the remote core so it can be sure to generate a
> signal to notify the process.
> 
> Separate patches that follow provide these changes for x86, tile,
> arm, and arm64.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   6 +
>  include/linux/isolation.h                       | 175 +++++++++++
>  include/linux/sched.h                           |   4 +
>  include/uapi/linux/prctl.h                      |   6 +
>  init/Kconfig                                    |  28 ++
>  kernel/Makefile                                 |   1 +
>  kernel/context_tracking.c                       |   2 +
>  kernel/isolation.c                              | 402 ++++++++++++++++++++++++
>  kernel/signal.c                                 |   2 +
>  kernel/sys.c                                    |   6 +
>  10 files changed, 631 insertions(+)
>  create mode 100644 include/linux/isolation.h
>  create mode 100644 kernel/isolation.c
 
[...]

> + * This routine is called from syscall entry, prevents most syscalls
> + * from executing, and if needed raises a signal to notify the process.
> + *
> + * Note that we have to stop isolation before we even print a message
> + * here, since otherwise we might end up reporting an interrupt due to
> + * kicking the printk handling code, rather than reporting the true
> + * cause of interrupt here.
> + */
> +int task_isolation_syscall(int syscall)
> +{

All callers of this function call it like this:
        if (work & _TIF_TASK_ISOLATION) {
                if (task_isolation_syscall(regs->syscallno) ==
                                -1)
                        return -1;
        }

Would it make sense to move check of _TIF_TASK_ISOLATION flag inside
the function?

> +	struct task_struct *task = current;
> +
> +	if (is_acceptable_syscall(syscall)) {
> +		stop_isolation(task);
> +		return 0;
> +	}
> +
> +	send_isolation_signal(task);
> +
> +	pr_warn("%s/%d (cpu %d): task_isolation lost due to syscall %d\n",
> +		task->comm, task->pid, smp_processor_id(), syscall);
> +	debug_dump_stack();
> +
> +	syscall_set_return_value(task, current_pt_regs(), -ERESTARTNOINTR, -1);
> +	return -1;
> +}

Yury

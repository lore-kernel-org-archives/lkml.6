Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2318607-1522917673-2-16438855082231945219
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='DE'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522917672; b=OuvflxKq3477TI1Tyha9g7V0nCp9NrBdZn2U0NOtiEvVlZEBTX
    UVGd/TXMBxMig0zGTbaSdM16qEpjlBLWzhCtI4/aSDhGmJVrAfGi8eJ24n9qc5Mj
    88R512f+BgR80oKKrMIvwGKa5QU//Nk31vhtHPchRQQVzBicfXHX5bxztpBpnxBX
    8yPBVBCCHeJKTUOQkBW4czxsQqeM2a1X6yUU+hhQC1+iY6ZvxrwD1zhxiUHOpSdO
    Vm+suD9a3FwHnLMLWDf2bOX77yfOG6p+D++1YShgEhyCexVuicGqd3mRHUR1Ts90
    SGH7HdJcXmA2565+I0Xg6VAb9JQNTd8QmPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522917672; bh=V2C1R0e8x3XR3lKxHQYNxmWYYgeiPp
    c8Ne0PXi+ZSc8=; b=dgKnzMmPTd20cQedGffPi8ilKygKnb+HneIztyqlC09CAv
    4AdafODs8qqXvE698C650rXd6jmFW7sFkzBJASGxMTaTfasZ+lyeIEz8YX7d/LdU
    RBvqm/Aseo9glF4O2L/LOcld5TDWmnFhteOJaZXrT+f3eSOxixGoJ0tajKzvCtYX
    9WTFKJ5sCRxVOpX2qvppR76ckMeDqWYsxnAfR6HPXAx2O4zSiIHbvYFRXR2SLrtq
    F2Usf3VAfD3WkvSjksb6LSazXOzvC5QU5FgrCDITc1DK+o0GAdNtL1q4J+JsP+BE
    +HtlhawmYEVNzPjw4PwoI4o6fCfaEWvwS2C23Q3A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=caviumnetworks.onmicrosoft.com header.i=@caviumnetworks.onmicrosoft.com header.b=anSkxnyn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=caviumnetworks.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=caviumnetworks.onmicrosoft.com header.i=@caviumnetworks.onmicrosoft.com header.b=anSkxnyn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=caviumnetworks.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMOTyLfJrB5V0qD1UuczyXeVd88fHj996EJL6sqe3RDBshibPbid68Doi9GBGDbT/elwOKxdoZXKGbyuSCGu29f8Z/CG+bwdyUsd4x/GqGcFhh5oQNF1
    FZZ1V2RZjAUUtBEFKPWZsilzA0S6Kg7XbJRXKs+Hwc7yV0/NoIM/A4aDQz8qQS/OtHSTTum8Q3C+rxM9B8rhxX8HriXFAKW37yupTBrOGRKEe9Py9GwOP3YO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=zK_ggSpaDNQA:10 a=DxXWA_PE7oUA:10 a=uwkydLvd-gkA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=ifRc6kEuNzAA:10 a=zAyngx5bAAAA:8 a=VwQbUJbxAAAA:8
    a=d3rpU748e4XZJxw73fAA:9 a=ai9h3rlndlIExbtb:21 a=5QM-5kvJdX9hRVyZ:21
    a=CjuIK1q_8ugA:10 a=4LA4qAFo6bo561LpWNDU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeDEIke (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 04:40:34 -0400
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:42933
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751097AbeDEIka (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 04:40:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com;
Date: Thu, 5 Apr 2018 10:40:18 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mahipal Challa <Mahipal.Challa@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] crypto: thunderx_zip: Fix fallout from
 CONFIG_VMAP_STACK
Message-ID: <20180405084018.GB24281@hc>
References: <20180328130557.10560-1-jglauber@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328130557.10560-1-jglauber@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.223.168.166]
X-ClientProxiedBy: AM5PR0201CA0003.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::13) To BN3PR07MB2499.namprd07.prod.outlook.com
 (2a01:111:e400:7bbf::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20985de9-2e5e-427f-56c5-08d59ad0e208
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN3PR07MB2499;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2499;3:rhSctHDYYYQCUUsb+2Ca2jeYNFq2W64ZB7psfuIACpFg7Ehj8mw5RnQcLlAkYhD+VaNkad7qs5q0XIkQD81AT9i7bW5z9JF6OZqSvbKQfpcakYlWVxo1wyRF9kCUKSqotL/o2HaFqM5dch38RwjMlZS0NZ/ABGDJYnwbyxCc7FW9YVh9LDwhHkiO6zpF9skFE+vhcKO6pPjBIcZg+GEJ6mUnjnPbSRxhTP/kHxV5U7CYghy/q2KFkyDgiF48wXsW;25:1S0O4CB1QoAmimsYeyCcQS+SvYS9audRbWTXdJZBNXjGAzWzdVXnQOfX1NtyR1GhuajTWkW5eKC98qB/b2yEarkf6sEJrz8k2wr+cjPBSF2XYQ0a9eBTPbU7MLD+YI4KO6l4OudKmo8RyFsN9Ja+UnLW4uMnusHbkyjNRRGzwGzn+dKhuD6LBmqUjTspT0jWn8eFeZ+x5zG+o4zqCBAoGS6SC4RNAuMRxmhOeY6eo4sYiNaD/apeffQIJfL5aMIy6bCH8ceLQYIiKMUDWiSXqbKc0m3bHXo1hLDxCP0exHFPhTq44jSF4X225nNs+NrLkwNkknl2Jocy1qRuMC0g6w==;31:aE07zNiZaSGjVVYIRT4+SI/0HzBEe8D2neEBUpEtj7MRcrvxwvxbaQizROvcn/4NsH3P/IaxAYczkwuxeqdhlxCzYDe+DZzyyBcjaUlx3DcX31VWO1W6dT48fuc6oeFwZGQjAcQdoLxElJBQ0u7gzBzidk7/QFcCP9QsBvIgTrMwEQ+ucqKDjZrgEa01kaiFnh9+txujFfqFd5PRXYp+BzHLcElwapiYhoSbt99gBws=
X-MS-TrafficTypeDiagnostic: BN3PR07MB2499:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2499;20:SrPGgWU057bEtEW7iuzxLqpen4nSp7KElTipZJJq6JowLLhSkINSShQku6Sm0mqtKTyEjBHMMvpDBFYMXEvMpMt6ScSM1X1NPO+BORMDvNbJWYbeltwp5Bb6MdYxusZG4LfPRWgwG0gMCzZfWgC2kDEK/Wv58JBB/54tzvMv3i+ZFc3c4yACcyUYEYx1IjSDSjPHUEmz7HG/ZSnUJgzTJ+FKjMRUPjZkw5MNHRsY6DXIpjvV3+KvKfOJi7Ko3Yvxpv9RY3HAlswsi7c+yEQTQFQfRqj5fzwYLBvdF81Hx+4qyk3gedNK3nUR3qBQUBNEvRwtBStUv7XPWadGpuWth/Db9uUKZ5KLLFa6y4w5TDIrnBM2FSkyq6N0RHPITKylE4d/mgpOR88YGu4/Vva2N65G7Y0jTQxy7Z9aGzKk/F4epOcjmTGLNRb28EP0RR7CJE522wO+VLLmyYD+8hre5w8o7h8W7DgSReWsVPO7txdYlHnqbMsUuLuPkKLBWMLYC/H4gfDvQ4etedDAGwEHJCnFiqSVuGM8z69iO0qw8cB3E3rLW4qchPfEX8ijIU5twbRpCM/haxwopvl6ThrBwWQUGX5wEXQcJD404nG216E=;4:FacbsVeDAlyXx7kpvZ2FlSxOHFivGSaxCoih0WTjfhl7/YZadKnPCaQBjNrLBUky+CzCKa3sO7rXwH0YmpvkFKZQEFhU3pZqTEBuGOoug58Q/ROnJ0fR/vtTmGrmnteCAzjXR91WEqs4223TE6O8tMiU6ROrssN9RJ4zcWybRTyW4LBwBUmdvei8TaY83EGpMel6Rj/eEVUnU60uXdwRnSPkp9cCgaeaGj2mCBQEV/MjBswnYD2Fc/6atZ/jQzt9gl5a39KlYEKrDIMDT9AFe8N1Q2uXRKLRpcl7WknaE4Yxe6yQeKQUXlGZ/KhTv6Od
X-Microsoft-Antispam-PRVS: <BN3PR07MB249936FDA070AAB44E283AEE91BB0@BN3PR07MB2499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231221)(944501327)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN3PR07MB2499;BCL:0;PCL:0;RULEID:;SRVR:BN3PR07MB2499;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39380400002)(376002)(39860400002)(366004)(199004)(189003)(76176011)(6916009)(72206003)(33896004)(25786009)(105586002)(52116002)(6666003)(6496006)(68736007)(66066001)(97736004)(42882007)(316002)(7736002)(2906002)(26005)(47776003)(23726003)(6116002)(386003)(59450400001)(478600001)(229853002)(55016002)(16526019)(956004)(1076002)(8936002)(16586007)(81166006)(50466002)(305945005)(3846002)(5660300001)(186003)(81156014)(476003)(446003)(53936002)(6246003)(11346002)(33716001)(486006)(54906003)(8676002)(4326008)(9686003)(33656002)(58126008)(106356001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2499;H:hc;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR07MB2499;23:SgNYa87lun4zQneU84udNapl3IUVaD5hD4zGyKI88?=
 =?us-ascii?Q?DNWFkepL2XmXBQjWLmAroz25nXXRNBT4ZfXfOdYOd5eQEbdn6y3Hr026t9oe?=
 =?us-ascii?Q?Ehn1essleofhM3zEwmrDRikZYUUgPCX9uE10OyZDp7DlePU7yalDul/AbrXn?=
 =?us-ascii?Q?SWwk+ld3cRE1cwg636cFiYBwx80QXAH7NSb2/xiR7ccw7tzwhAqnefwKTEyo?=
 =?us-ascii?Q?aoai7wGaz9isEvV0YJAS3LECWcKO2CetrmBr2HQZ0GqvdBG930bUSJUpcsWI?=
 =?us-ascii?Q?rKyh7BepnZgrrHwp7R1AX6g0fs8tDIn+/REZliA+5mKjGeTxuy7LaCLKaR1J?=
 =?us-ascii?Q?jAotdbrvgfZ82CYLJseTLFM1asDxXoGX5fIknIGlJ4IwRhFXXpP/wETII2EF?=
 =?us-ascii?Q?SYj2MFDH33ffy9BkSArhmnULBrnUlIxKStWtUfrP+AR3WAHuT1QVIpL5jk0a?=
 =?us-ascii?Q?sa0V3TXyqvwOQjzvcO5gn/10p0PEd7CGp8EpG5kuomTRfi5R5CsBXdNGro7f?=
 =?us-ascii?Q?bmr1beplmPyA8eJuDz1WbZOquGRgF4BuIJjZU3tEzwAi6fs1Uz6mzAVDcXac?=
 =?us-ascii?Q?7d0uFW2sOfDU0KkgssK+qBYhg4ECjJOSqBbpzjRbOzJ69ssgt1fCv16CEEti?=
 =?us-ascii?Q?TSFPe8t4u7csYwb8ufjXF03XgrSNsDkSQ9hCWq+AnT/EfSsor7THvCMzRGQx?=
 =?us-ascii?Q?ozoTpVWxvv14SHP2SWdaPBraYFR47f5hfcHiKOm2wSlRZwV9hVZNgvI25ymo?=
 =?us-ascii?Q?r64kTajZTNWGOl3nM8/ctHps4eZGcEAs9xeGGJyxIxYzxnpcJ2oZWvnkwKbh?=
 =?us-ascii?Q?oR1CwdWhJQSO62ZG4NP0zeHMf2vQutij7Gw3tv23B/K/W1ffcyTdZ4C09IDl?=
 =?us-ascii?Q?HwZUIpYbCUNnJl/yoqPevXsCISWsOZXJKIVg5SG3RUtlVlJeNuC8mVysHTUb?=
 =?us-ascii?Q?65Ime7yIpFzaMJLVpaf2WmwqCxJdFDnGm2SVN6rWY8okB7k4KAfVzxNx9RpD?=
 =?us-ascii?Q?9uyixXe2uvViCpSH6Ik5flrshfO9WoBnAUv2m+NgmURJ+gG08T0/TwVnTsVq?=
 =?us-ascii?Q?QKIFP7cDR0N/ialN96GGrfOql+bhCPE/GHNlygUPJ2WDntn+bns2+LvnbZjv?=
 =?us-ascii?Q?wXraHwukYFasfUfor9D0eBeAwyuRbBiF1KHl6xUjdQhh0nVD24j12U6D0O48?=
 =?us-ascii?Q?lwFiIHI5MSAVnSz/1g23e72My948RpIWqHfuwJLSsl8rVEdQCjlKAlVK0nns?=
 =?us-ascii?Q?hegmMnsnAK00aojVsDaPTnEzgPG0482Wft4JGnmA92IoE1XQORA+CMc1PiAz?=
 =?us-ascii?Q?h8/F95bskvqoSzss2tVefIPzUhaTJtGz/Rbf3UJU041?=
X-Microsoft-Antispam-Message-Info: LqLDS/NMfs3K27MBZ23VmWo67XGjf+NAWiMxcO/i/VHNiWai0seuJiCn+jZO3cMb8OVO8Bm1/Dp95tZJ2DXLU2sNrCaftrQv2RPYaU5h9BPOBWYQKesZfT6TDfDkymeC2JfB0NiGV18+X1QAtcQeAoCfEiQkEIqjuOBzv+sfSTG4OETG3+zMWjRUzudDUlah
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2499;6:WWpDG3N5eo1wYyfr7nl6mUVrd7jCgiqPSOW2qjM6A0AM4UwpbBXKSWytLhdV8k7M1UYjory8/zswA06fPAzOzlDnL1mxwIjSxO8ICKuglKz2cbnU7kir6zznvePwvhCb0R48Q1EObJ4tsek0QYKmsqxO7S4/oTotm7UxqHJZc74ZmY5s3sTKaUV5GmnI9jhVVHTWvZIaVVW61G65F5qpGeUUEds9kgxSvy/UPy4SAWgo1N9/1cvwPfksR6W/oYchDQ65wzUTFi7xMhKvM7V4aXNVa9rhzP3/LQE7OjK3gR94xFPzwVEaXQVune7xbRUS8mcauqVi+Qw3QsHt+JwOq673pnhHB92c5jrCQbrP04tVDGYVjToMx97hltBgHMjjP0eqTzB9Hs4hFMWNVrw0bck5/ZPvSDsb8++3TvzERNu0WGUjvm89t1UuS8r1je/VBuWa95rA+XHs0P13h37Y4w==;5:JZMBUB0mkNx6MBS7bM12eEUdhp+m6bEELneFQ88s6dwt2+ThEmuFAuzSSTYc9cM6iFfoIdVSmdp8xVlm80/RSToxnQq6g+GaA/bXAMb2RlXrAWxVqR/q76R70Xg9HQ2L54Vy5f3bLgeHA8N47oQ/9UYbI89o2HIIvGdPRdVrEPo=;24:+Nz+kdOlCstTwx/uSYyFJaLBTaQjgG9WlhgB4Kxx5R3GhVzYgXZU/5/zPwlRfgetPfT2DDx7NxFgv4Vim5hSR7M44Zdnvo4tK1tdsgjwAFk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2499;7:polqFEnDONg5K5+i9fQmOWM8tZL9ExIunBFnc6qy9UMjvAXIXKHfqj7umGgcEvx8KkKfuwA77eLC2l+tYu46jVFQZB7FapEH5CYJ0QH8ECOfCJc6ZTON06TgF30AinY2jv+e3eCGgmFT6rRmpFV5dLnpGIp5tVSL1DDjqXnCbq6bs1y4u+amnvcyR96bRNOu/feQvRTRFqNTcQgiWpk6dJTKOYobXqPVoXFkM9DUC8SizYNpxzRDZrlZIlngUycC
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 08:40:26.7771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20985de9-2e5e-427f-56c5-08d59ad0e208
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2499
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 03:05:56PM +0200, Jan Glauber wrote:
> Enabling virtual mapped kernel stacks breaks the thunderx_zip
> driver. On compression or decompression the executing CPU hangs
> in an endless loop. The reason for this is the usage of __pa
> by the driver which does no longer work for an address that is
> not part of the 1:1 mapping.
> 
> The zip driver allocates a result struct on the stack and needs
> to tell the hardware the physical address within this struct
> that is used to signal the completion of the request.
> 
> As the hardware gets the wrong address after the broken __pa
> conversion it writes to an arbitrary address. The zip driver then
> waits forever for the completion byte to contain a non-zero value.
> 
> Allocating the result struct from 1:1 mapped memory resolves this
> bug.

Hi Herbert,

Just realized that we might sleep in this path, so GFP_KERNEL wont
work here. Same with usleep in the second patch.

I'll respin the patches.

--Jan


> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Cc: stable <stable@vger.kernel.org> # 4.14
> ---
>  drivers/crypto/cavium/zip/zip_crypto.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/crypto/cavium/zip/zip_crypto.c b/drivers/crypto/cavium/zip/zip_crypto.c
> index 8df4d26..2fc9b03 100644
> --- a/drivers/crypto/cavium/zip/zip_crypto.c
> +++ b/drivers/crypto/cavium/zip/zip_crypto.c
> @@ -124,7 +124,7 @@ int zip_compress(const u8 *src, unsigned int slen,
>                  struct zip_kernel_ctx *zip_ctx)
>  {
>         struct zip_operation  *zip_ops   = NULL;
> -       struct zip_state      zip_state;
> +       struct zip_state      *zip_state;
>         struct zip_device     *zip = NULL;
>         int ret;
> 
> @@ -135,20 +135,23 @@ int zip_compress(const u8 *src, unsigned int slen,
>         if (!zip)
>                 return -ENODEV;
> 
> -       memset(&zip_state, 0, sizeof(struct zip_state));
> +       zip_state = kzalloc(sizeof(*zip_state), GFP_KERNEL);
> +       if (!zip_state)
> +               return -ENOMEM;
> +
>         zip_ops = &zip_ctx->zip_comp;
> 
>         zip_ops->input_len  = slen;
>         zip_ops->output_len = *dlen;
>         memcpy(zip_ops->input, src, slen);
> 
> -       ret = zip_deflate(zip_ops, &zip_state, zip);
> +       ret = zip_deflate(zip_ops, zip_state, zip);
> 
>         if (!ret) {
>                 *dlen = zip_ops->output_len;
>                 memcpy(dst, zip_ops->output, *dlen);
>         }
> -
> +       kfree(zip_state);
>         return ret;
>  }
> 
> @@ -157,7 +160,7 @@ int zip_decompress(const u8 *src, unsigned int slen,
>                    struct zip_kernel_ctx *zip_ctx)
>  {
>         struct zip_operation  *zip_ops   = NULL;
> -       struct zip_state      zip_state;
> +       struct zip_state      *zip_state;
>         struct zip_device     *zip = NULL;
>         int ret;
> 
> @@ -168,7 +171,10 @@ int zip_decompress(const u8 *src, unsigned int slen,
>         if (!zip)
>                 return -ENODEV;
> 
> -       memset(&zip_state, 0, sizeof(struct zip_state));
> +       zip_state = kzalloc(sizeof(*zip_state), GFP_KERNEL);
> +       if (!zip_state)
> +               return -ENOMEM;
> +
>         zip_ops = &zip_ctx->zip_decomp;
>         memcpy(zip_ops->input, src, slen);
> 
> @@ -179,13 +185,13 @@ int zip_decompress(const u8 *src, unsigned int slen,
>         zip_ops->input_len  = slen;
>         zip_ops->output_len = *dlen;
> 
> -       ret = zip_inflate(zip_ops, &zip_state, zip);
> +       ret = zip_inflate(zip_ops, zip_state, zip);
> 
>         if (!ret) {
>                 *dlen = zip_ops->output_len;
>                 memcpy(dst, zip_ops->output, *dlen);
>         }
> -
> +       kfree(zip_state);
>         return ret;
>  }
> 
> --
> 2.7.4
